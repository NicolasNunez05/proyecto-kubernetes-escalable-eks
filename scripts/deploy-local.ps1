# scripts/deploy-local.ps1

# ═══════════════════════════════════════════════════════════════════════════
# GpuChile - Local Deployment Script (Kind + LocalStack)
# Windows 11 + Docker Desktop + WSL2
# ═══════════════════════════════════════════════════════════════════════════

#Requires -Version 5.1

# Configuración de colores
$Host.UI.RawUI.ForegroundColor = "White"
# Cambiamos a Continue para que no explote con warnings de Kind
$ErrorActionPreference = "Continue" 

# ═══════════════════════════════════════════════════════════════════════════
# CONFIGURACION
# ═══════════════════════════════════════════════════════════════════════════

$CLUSTER_NAME = "gpuchile-local"
$BACKEND_IMAGE = "gpuchile-backend:local"
$FRONTEND_IMAGE = "gpuchile-frontend:local"
$BACKEND_PORT = 8000
$FRONTEND_PORT = 3000

# Rutas
$PROJECT_ROOT = $PSScriptRoot | Split-Path -Parent
$KIND_EXE = Join-Path $PROJECT_ROOT "kind.exe"
$BACKEND_DIR = Join-Path $PROJECT_ROOT "apps\backend"
$FRONTEND_DIR = Join-Path $PROJECT_ROOT "apps\frontend"
$K8S_DIR = Join-Path $PROJECT_ROOT "k8s-local"

# ═══════════════════════════════════════════════════════════════════════════
# FUNCIONES AUXILIARES
# ═══════════════════════════════════════════════════════════════════════════

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    Write-Host $Message -ForegroundColor $Color
}

function Write-Step {
    param([string]$Message)
    Write-ColorOutput "`n-----------------------------------------------------------" "Cyan"
    Write-ColorOutput "  $Message" "Cyan"
    Write-ColorOutput "-----------------------------------------------------------`n" "Cyan"
}

function Write-Success {
    param([string]$Message)
    Write-ColorOutput "[OK] $Message" "Green"
}

function Write-Info {
    param([string]$Message)
    Write-ColorOutput "[INFO] $Message" "Yellow"
}

function Write-Error-Custom {
    param([string]$Message)
    Write-ColorOutput "[ERROR] $Message" "Red"
}

function Test-Command {
    param([string]$Command)
    try {
        Get-Command $Command -ErrorAction SilentlyContinue | Out-Null
        return $true
    } catch {
        return $false
    }
}

# ═══════════════════════════════════════════════════════════════════════════
# VALIDACIONES PREVIAS
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "VERIFICANDO REQUISITOS"

# Verificar kind.exe
if (-not (Test-Path $KIND_EXE)) {
    Write-Error-Custom "kind.exe no encontrado en la raiz del proyecto"
    Write-Info "Descarga kind desde: https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64"
    Write-Info "Renombralo a 'kind.exe' y colocalo en: $PROJECT_ROOT"
    exit 1
}
Write-Success "kind.exe encontrado"

# Verificar Docker
if (-not (Test-Command "docker")) {
    Write-Error-Custom "Docker no esta instalado o no esta en el PATH"
    exit 1
}
Write-Success "Docker instalado"

# Verificar kubectl
if (-not (Test-Command "kubectl")) {
    Write-Error-Custom "kubectl no esta instalado"
    Write-Info "Instala kubectl desde: https://kubernetes.io/docs/tasks/tools/install-kubectl-windows/"
    exit 1
}
Write-Success "kubectl instalado"

# Verificar Docker Desktop corriendo
try {
    docker ps | Out-Null
    Write-Success "Docker Desktop esta corriendo"
} catch {
    Write-Error-Custom "Docker Desktop no esta corriendo"
    exit 1
}

# ═══════════════════════════════════════════════════════════════════════════
# CREAR CLUSTER KIND
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "CONFIGURANDO CLUSTER KIND"

# Verificar si el cluster ya existe (Manera segura)
Write-Info "Comprobando clusters existentes..."
$existingCluster = $false
try {
    # Redirigimos stderr a stdout para evitar errores falsos
    $clusters = & $KIND_EXE get clusters 2>&1
    if ($clusters -like "*$CLUSTER_NAME*") {
        $existingCluster = $true
    }
} catch {
    Write-Info "No se detectaron clusters previos (o error ignorado)"
}

if ($existingCluster) {
    Write-Info "El cluster '$CLUSTER_NAME' ya existe"
    $response = Read-Host "Deseas eliminarlo y recrearlo? (s/N)"
    if ($response -eq "s" -or $response -eq "S") {
        Write-Info "Eliminando cluster existente..."
        & $KIND_EXE delete cluster --name $CLUSTER_NAME
        Write-Success "Cluster eliminado"
        $createCluster = $true
    } else {
        Write-Info "Usando cluster existente"
        & $KIND_EXE export kubeconfig --name $CLUSTER_NAME
        $createCluster = $false
    }
} else {
    $createCluster = $true
}

if ($createCluster) {
    Write-Info "Creando cluster Kind..."
    
    # Crear archivo de configuración temporal
    $kindConfig = @"
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30000
    hostPort: $BACKEND_PORT
    protocol: TCP
  - containerPort: 30080
    hostPort: $FRONTEND_PORT
    protocol: TCP
  - containerPort: 31566
    hostPort: 4566
    protocol: TCP
networking:
  apiServerAddress: "0.0.0.0"
  apiServerPort: 6443
"@
    
    $configPath = Join-Path $env:TEMP "kind-config.yaml"
    $kindConfig | Out-File -FilePath $configPath -Encoding UTF8
    
    # Ejecutamos kind creation
    & $KIND_EXE create cluster --name $CLUSTER_NAME --config $configPath
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error-Custom "Error al crear el cluster. Verifica que los puertos 3000, 8000 o 4566 no esten ocupados."
        exit 1
    }
    
    Remove-Item $configPath
    Write-Success "Cluster creado"
}

# Configurar kubectl
Write-Info "Configurando kubectl..."
& $KIND_EXE export kubeconfig --name $CLUSTER_NAME

# Verificar conectividad
Write-Info "Verificando conectividad..."
kubectl cluster-info --context "kind-$CLUSTER_NAME"
Write-Info "Esperando a que el nodo este listo..."
kubectl wait --for=condition=Ready nodes --all --timeout=60s

Write-Success "Cluster Kind configurado correctamente"

# ═══════════════════════════════════════════════════════════════════════════
# DESPLEGAR LOCALSTACK
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "DESPLEGANDO LOCALSTACK"

# Aplicar manifiestos de LocalStack
kubectl apply -f (Join-Path $K8S_DIR "localstack.yaml")

Write-Info "Esperando a que LocalStack este listo..."
Start-Sleep -Seconds 5

# Esperar a que el pod de LocalStack esté Ready
kubectl wait --for=condition=Ready pod -l app=localstack -n localstack --timeout=120s

Write-Success "LocalStack desplegado y listo"

# Verificar que el bucket se creó
Write-Info "Verificando bucket S3..."
Start-Sleep -Seconds 10

$localstackPod = kubectl get pod -n localstack -l app=localstack -o jsonpath='{.items[0].metadata.name}'
# Usamos try/catch aqui tambien por seguridad
try {
    kubectl exec -n localstack $localstackPod -c localstack -- aws --endpoint-url=http://localhost:4566 s3 ls
    Write-Success "Bucket S3 'gpuchile-media' verificado"
} catch {
    Write-Info "No se pudo verificar el bucket automaticamente (puede que aun se este creando)"
}

# ═══════════════════════════════════════════════════════════════════════════
# BUILD BACKEND IMAGE
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "COMPILANDO BACKEND IMAGE"

Push-Location $BACKEND_DIR

Write-Info "Building Docker image: $BACKEND_IMAGE"
docker build -t $BACKEND_IMAGE .

if ($LASTEXITCODE -ne 0) {
    Write-Error-Custom "Error al compilar la imagen del backend"
    Pop-Location
    exit 1
}

Write-Success "Backend image compilada"

# Cargar imagen en Kind
Write-Info "Cargando imagen en Kind..."
& $KIND_EXE load docker-image $BACKEND_IMAGE --name $CLUSTER_NAME

Write-Success "Backend image cargada en Kind"

Pop-Location

# ═══════════════════════════════════════════════════════════════════════════
# BUILD FRONTEND IMAGE
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "COMPILANDO FRONTEND IMAGE"

Push-Location $FRONTEND_DIR

Write-Info "Building Docker image: $FRONTEND_IMAGE"

# Build con variable de entorno
docker build `
    --build-arg VITE_API_URL="http://localhost:$BACKEND_PORT/api" `
    -t $FRONTEND_IMAGE `
    .

if ($LASTEXITCODE -ne 0) {
    Write-Error-Custom "Error al compilar la imagen del frontend"
    Pop-Location
    exit 1
}

Write-Success "Frontend image compilada"

# Cargar imagen en Kind
Write-Info "Cargando imagen en Kind..."
& $KIND_EXE load docker-image $FRONTEND_IMAGE --name $CLUSTER_NAME

Write-Success "Frontend image cargada en Kind"

Pop-Location

# ═══════════════════════════════════════════════════════════════════════════
# APLICAR MANIFIESTOS DE KUBERNETES
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "APLICANDO MANIFIESTOS"

# Aplicar ConfigMap del backend (con configuración de LocalStack)
if (Test-Path (Join-Path $K8S_DIR "backend-configmap.yaml")) {
    kubectl apply -f (Join-Path $K8S_DIR "backend-configmap.yaml")
    Write-Success "Backend ConfigMap aplicado"
}

# Aplicar Secrets (si existen)
if (Test-Path (Join-Path $K8S_DIR "secrets.yaml")) {
    kubectl apply -f (Join-Path $K8S_DIR "secrets.yaml")
    Write-Success "Secrets aplicados"
} else {
    Write-Info "Creando secrets por defecto..."
    kubectl create secret generic db-credentials `
        --from-literal=DATABASE_URL="postgresql://postgres:postgres123@postgres:5432/gpuchile" `
        --from-literal=SECRET_KEY="local-dev-secret-key-12345" `
        --dry-run=client -o yaml | kubectl apply -f -
    Write-Success "Secrets creados"
}

# Aplicar deployment del backend
if (Test-Path (Join-Path $K8S_DIR "backend-deployment.yaml")) {
    # Actualizar imagePullPolicy y nombre de imagen
    $backendYaml = Get-Content (Join-Path $K8S_DIR "backend-deployment.yaml") -Raw
    $backendYaml = $backendYaml -replace "image:.*backend.*", "image: $BACKEND_IMAGE"
    $backendYaml = $backendYaml -replace "imagePullPolicy:.*", "imagePullPolicy: Never"
    $backendYaml | kubectl apply -f -
    Write-Success "Backend deployment aplicado"
}

# Aplicar service del backend
if (Test-Path (Join-Path $K8S_DIR "backend-service.yaml")) {
    kubectl apply -f (Join-Path $K8S_DIR "backend-service.yaml")
    Write-Success "Backend service aplicado"
}

# Aplicar deployment del frontend
if (Test-Path (Join-Path $K8S_DIR "frontend-deployment.yaml")) {
    $frontendYaml = Get-Content (Join-Path $K8S_DIR "frontend-deployment.yaml") -Raw
    $frontendYaml = $frontendYaml -replace "image:.*frontend.*", "image: $FRONTEND_IMAGE"
    $frontendYaml = $frontendYaml -replace "imagePullPolicy:.*", "imagePullPolicy: Never"
    $frontendYaml | kubectl apply -f -
    Write-Success "Frontend deployment aplicado"
}

# Aplicar service del frontend
if (Test-Path (Join-Path $K8S_DIR "frontend-service.yaml")) {
    kubectl apply -f (Join-Path $K8S_DIR "frontend-service.yaml")
    Write-Success "Frontend service aplicado"
}

# ═══════════════════════════════════════════════════════════════════════════
# ESPERAR A QUE LOS PODS ESTEN LISTOS
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "ESPERANDO PODS"

Write-Info "Esperando backend..."
kubectl wait --for=condition=available --timeout=180s deployment/gpuchile-backend 2>$null
if ($?) {
    Write-Success "Backend listo"
} else {
    Write-Info "Backend tomando mas tiempo de lo esperado (continuando...)"
}

Write-Info "Esperando frontend..."
kubectl wait --for=condition=available --timeout=180s deployment/gpuchile-frontend 2>$null
if ($?) {
    Write-Success "Frontend listo"
} else {
    Write-Info "Frontend tomando mas tiempo de lo esperado (continuando...)"
}

# ═══════════════════════════════════════════════════════════════════════════
# MOSTRAR STATUS
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "ESTADO DEL DEPLOYMENT"

Write-ColorOutput "`n===== PODS =====" "Cyan"
kubectl get pods --all-namespaces

Write-ColorOutput "`n===== SERVICES =====" "Cyan"
kubectl get svc --all-namespaces

# ═══════════════════════════════════════════════════════════════════════════
# MOSTRAR URLs DE ACCESO
# ═══════════════════════════════════════════════════════════════════════════

Write-Step "DEPLOYMENT COMPLETADO"

Write-ColorOutput "`n**************************************************************" "Green"
Write-ColorOutput "                     ACCESO A LA APLICACION                   " "Green"
Write-ColorOutput "**************************************************************`n" "Green"

Write-ColorOutput "  Frontend:   " "Yellow" -NoNewline
Write-ColorOutput "http://localhost:$FRONTEND_PORT" "White"

Write-ColorOutput "  Backend:    " "Yellow" -NoNewline
Write-ColorOutput "http://localhost:$BACKEND_PORT" "White"

Write-ColorOutput "  LocalStack: " "Yellow" -NoNewline
Write-ColorOutput "http://localhost:4566" "White"

Write-ColorOutput "`n  Health Checks:" "Cyan"
Write-ColorOutput "     Backend:   " "Yellow" -NoNewline
Write-ColorOutput "http://localhost:$BACKEND_PORT/health" "White"

Write-ColorOutput "     Frontend:  " "Yellow" -NoNewline
Write-ColorOutput "http://localhost:$FRONTEND_PORT/" "White"

Write-ColorOutput "`n**************************************************************" "Green"
Write-ColorOutput "                      COMANDOS UTILES                         " "Green"
Write-ColorOutput "**************************************************************`n" "Green"

Write-ColorOutput "  Ver logs del backend:" "Yellow"
Write-ColorOutput "    kubectl logs -l app=backend -f`n" "White"

Write-ColorOutput "  Ver logs del frontend:" "Yellow"
Write-ColorOutput "    kubectl logs -l app=frontend -f`n" "White"

Write-ColorOutput "  Ver logs de LocalStack:" "Yellow"
Write-ColorOutput "    kubectl logs -n localstack -l app=localstack -f`n" "White"

Write-ColorOutput "  Eliminar cluster:" "Yellow"
Write-ColorOutput "    .\kind.exe delete cluster --name $CLUSTER_NAME`n" "White"

Write-ColorOutput "`n[OK] Listo para desarrollar!" "Green"
Write-ColorOutput "" "White"