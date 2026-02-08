<#
.SYNOPSIS
    Script de seguridad para destruir infraestructura en AWS tras X horas.
    Evita costos accidentales por dejar el laboratorio encendido.
#>

# ⚠️ CONFIGURACIÓN: Cambia esto según tus horas de estudio
$Horas = 4
$Segundos = $Horas * 3600

# Calcular tiempos
$FechaInicio = Get-Date
$FechaFin = $FechaInicio.AddHours($Horas)
$CostoEstimado = $Horas * 0.12 # Costo aprox por hora de EKS + Nodos Spot

Clear-Host
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   ⏰ AUTO-DESTROY DE INFRAESTRUCTURA   " -ForegroundColor Cyan
Write-Host "============================================"
Write-Host "📍 Inicio: $FechaInicio"
Write-Host "🔥 DESTRUCCIÓN PROGRAMADA: $FechaFin"
Write-Host "💰 Costo máx. estimado sesión: `$$CostoEstimado USD"
Write-Host ""
Write-Host "⚠️  IMPORTANTE:" -ForegroundColor Yellow
Write-Host "1. NO cierres esta terminal de VS Code."
Write-Host "2. Si tu PC se suspende, el contador se pausa."
Write-Host "3. Para cancelar, presiona Ctrl+C en esta ventana."
Write-Host "============================================"

# Esperar el tiempo definido
Start-Sleep -Seconds $Segundos

# --- COMIENZA LA DESTRUCCIÓN ---
Write-Host ""
Write-Host "⏰ Tiempo expirado. Iniciando destrucción..." -ForegroundColor Red

# Navegar a la carpeta terraform relativa a este script
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location "$ScriptPath\..\..\terraform"

# Ejecutar Terraform
terraform destroy -auto-approve

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Infraestructura destruida exitosamente." -ForegroundColor Green
    Write-Host "💰 Ahorro asegurado." -ForegroundColor Green
} else {
    Write-Host "❌ Error al destruir. Revisa la consola." -ForegroundColor Red
}