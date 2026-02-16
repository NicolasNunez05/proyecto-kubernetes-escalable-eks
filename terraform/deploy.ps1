<#
.SYNOPSIS
    Deploy/Destroy script para GpuChile EKS Project
.DESCRIPTION
    Automatiza el deployment en 2 fases: Infrastructure -> Applications
.PARAMETER Action
    Opciones: deploy, destroy, plan, validate
.EXAMPLE
    .\deploy.ps1 -Action deploy
    .\deploy.ps1 -Action plan
    .\deploy.ps1 -Action destroy
#>

param (
    [ValidateSet("deploy", "destroy", "plan", "validate")]
    [string]$Action = "deploy"
)

$ErrorActionPreference = "Stop"
$ClusterName = "gpuchile-cluster"
$Region = "us-east-1"

# ============================================
# FUNCIONES AUXILIARES
# ============================================

function Write-Step {
    param([string]$Message)
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "  $Message" -ForegroundColor Yellow
    Write-Host "========================================`n" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "OK $Message" -ForegroundColor Green
}

function Write-ErrorMsg {
    param([string]$Message)
    Write-Host "ERROR $Message" -ForegroundColor Red
}

function Test-Prerequisites {
    Write-Step "Verificando prerrequisitos"
    
    $tools = @(
        @{Name="aws"; Command="aws --version"},
        @{Name="terraform"; Command="terraform version"},
        @{Name="kubectl"; Command="kubectl version --client"}
    )
    
    $allPresent = $true
    foreach ($tool in $tools) {
        try {
            $null = Invoke-Expression $tool.Command 2>&1
            Write-Success "$($tool.Name) esta instalado"
        }
        catch {
            Write-ErrorMsg "$($tool.Name) NO esta instalado o no esta en PATH"
            $allPresent = $false
        }
    }
    
    if (-not $allPresent) {
        throw "Faltan herramientas requeridas. Instalalas antes de continuar."
    }
    
    Write-Success "Todos los prerrequisitos estan presentes"
}

function Run-Terraform {
    param (
        [string]$Phase,
        [string]$Command
    )
    
    $path = Join-Path $PSScriptRoot $Phase
    
    if (-not (Test-Path $path)) {
        throw "La carpeta $Phase no existe en $PSScriptRoot"
    }
    
    Write-Host "Ejecutando: terraform $Command en $Phase" -ForegroundColor Cyan
    Push-Location $path
    
    try {
        switch ($Command) {
            "init" { 
                terraform init 
            }
            "plan" { 
                terraform plan -out=tfplan 
            }
            "apply" { 
                if (Test-Path "tfplan") {
                    terraform apply tfplan
                } else {
                    terraform apply -auto-approve 
                }
            }
            "destroy" { 
                terraform destroy -auto-approve 
            }
            "validate" { 
                terraform validate 
            }
        }
        
        if ($LASTEXITCODE -ne 0) {
            throw "Terraform $Command fallo con codigo $LASTEXITCODE"
        }
    }
    finally {
        Pop-Location
    }
}

function Wait-ForEKSCluster {
    Write-Step "Esperando que el cluster EKS este listo"
    
    $maxAttempts = 30
    $attempt = 0
    
    while ($attempt -lt $maxAttempts) {
        $attempt++
        Write-Host "Intento $attempt/$maxAttempts - Verificando estado del cluster" -ForegroundColor Yellow
        
        try {
            # Verificar que el cluster existe en AWS
            $clusterStatus = aws eks describe-cluster --name $ClusterName --region $Region --query "cluster.status" --output text 2>$null
            
            if ($clusterStatus -eq "ACTIVE") {
                Write-Success "Cluster EKS esta ACTIVE"
                
                # Configurar kubectl
                Write-Host "Configurando kubectl" -ForegroundColor Cyan
                aws eks update-kubeconfig --name $ClusterName --region $Region
                
                # Verificar que los nodos esten ready
                Start-Sleep -Seconds 10
                $nodes = kubectl get nodes --no-headers 2>$null
                
                if ($LASTEXITCODE -eq 0 -and $nodes) {
                    Write-Success "Nodos estan disponibles:"
                    kubectl get nodes
                    return $true
                }
            }
        }
        catch {
            Write-Host "Esperando... ($($_.Exception.Message))" -ForegroundColor DarkYellow
        }
        
        Start-Sleep -Seconds 30
    }
    
    throw "Timeout: El cluster no estuvo listo despues de $($maxAttempts * 30) segundos"
}

# ============================================
# COMANDOS PRINCIPALES
# ============================================

function Invoke-Deploy {
    Write-Step "INICIANDO DEPLOYMENT COMPLETO"
    
    Test-Prerequisites
    
    # FASE 1: INFRAESTRUCTURA
    Write-Step "FASE 1: INFRAESTRUCTURA (VPC, EKS, RDS, S3)"
    Run-Terraform -Phase "1-infrastructure" -Command "init"
    Run-Terraform -Phase "1-infrastructure" -Command "apply"
    
    # Esperar que el cluster este listo
    Wait-ForEKSCluster
    
    # FASE 2: APLICACIONES
    Write-Step "FASE 2: APLICACIONES (Helm, K8s Manifests)"
    Run-Terraform -Phase "2-applications" -Command "init"
    Run-Terraform -Phase "2-applications" -Command "apply"
    
    Write-Step "DEPLOYMENT COMPLETO EXITOSO"
    Write-Host "`nProximos pasos:" -ForegroundColor Green
    Write-Host "  1. Verificar pods: kubectl get pods -A" -ForegroundColor White
    Write-Host "  2. Ver servicios: kubectl get svc -A" -ForegroundColor White
    Write-Host "  3. Acceder a Grafana: kubectl port-forward -n monitoring svc/prometheus-stack-grafana 3000:80" -ForegroundColor White
}

function Invoke-Plan {
    Write-Step "EJECUTANDO PLAN (SIN APLICAR CAMBIOS)"
    
    Test-Prerequisites
    
    Write-Step "FASE 1: Plan de Infraestructura"
    Run-Terraform -Phase "1-infrastructure" -Command "init"
    Run-Terraform -Phase "1-infrastructure" -Command "plan"
    
    Write-Step "FASE 2: Plan de Aplicaciones"
    Run-Terraform -Phase "2-applications" -Command "init"
    Run-Terraform -Phase "2-applications" -Command "plan"
    
    Write-Success "Plan completado. Revisa los cambios antes de hacer deploy."
}

function Invoke-Validate {
    Write-Step "VALIDANDO CONFIGURACION DE TERRAFORM"
    
    Write-Host "Validando FASE 1" -ForegroundColor Cyan
    Run-Terraform -Phase "1-infrastructure" -Command "init"
    Run-Terraform -Phase "1-infrastructure" -Command "validate"
    
    Write-Host "Validando FASE 2" -ForegroundColor Cyan
    Run-Terraform -Phase "2-applications" -Command "init"
    Run-Terraform -Phase "2-applications" -Command "validate"
    
    Write-Success "Validacion completada sin errores"
}

function Invoke-Destroy {
    Write-Step "INICIANDO DESTRUCCION TOTAL"
    
    $confirmation = Read-Host "Estas SEGURO que quieres destruir TODA la infraestructura? (yes/no)"
    if ($confirmation -ne "yes") {
        Write-Host "Destruccion cancelada." -ForegroundColor Yellow
        return
    }
    
    # ORDEN INVERSO: Primero apps, luego infra
    Write-Step "Destruyendo FASE 2: Aplicaciones"
    try {
        Run-Terraform -Phase "2-applications" -Command "destroy"
    }
    catch {
        Write-Warning "Error al destruir aplicaciones (puede que no existan): $_"
    }
    
    Write-Step "Destruyendo FASE 1: Infraestructura"
    Run-Terraform -Phase "1-infrastructure" -Command "destroy"
    
    Write-Step "DESTRUCCION COMPLETADA"
}

# ============================================
# ENTRY POINT
# ============================================

try {
    switch ($Action) {
        "deploy"   { Invoke-Deploy }
        "plan"     { Invoke-Plan }
        "validate" { Invoke-Validate }
        "destroy"  { Invoke-Destroy }
    }
}
catch {
    $errorMsg = $_.Exception.Message
    Write-ErrorMsg "Error fatal: $errorMsg"
    Write-Host $_.ScriptStackTrace -ForegroundColor Red
    exit 1
}
