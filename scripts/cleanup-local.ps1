# ═══════════════════════════════════════════════════════════════════════════
# GpuChile - Cleanup Script
# ═══════════════════════════════════════════════════════════════════════════

$PROJECT_ROOT = $PSScriptRoot | Split-Path -Parent
$KIND_EXE = Join-Path $PROJECT_ROOT "kind.exe"
$CLUSTER_NAME = "gpuchile-local"

Write-Host "`n🧹 Limpiando entorno local..." -ForegroundColor Yellow

# Eliminar cluster Kind
if (Test-Path $KIND_EXE) {
    Write-Host "Eliminando cluster Kind..." -ForegroundColor Yellow
    & $KIND_EXE delete cluster --name $CLUSTER_NAME
    Write-Host "✅ Cluster eliminado" -ForegroundColor Green
} else {
    Write-Host "❌ kind.exe no encontrado" -ForegroundColor Red
}

# Limpiar imágenes Docker (opcional)
$response = Read-Host "`n¿Deseas eliminar también las imágenes Docker? (s/N)"
if ($response -eq "s" -or $response -eq "S") {
    Write-Host "Eliminando imágenes Docker..." -ForegroundColor Yellow
    docker rmi gpuchile-backend:local -f 2>$null
    docker rmi gpuchile-frontend:local -f 2>$null
    Write-Host "✅ Imágenes eliminadas" -ForegroundColor Green
}

Write-Host "`n✅ Limpieza completada`n" -ForegroundColor Green
