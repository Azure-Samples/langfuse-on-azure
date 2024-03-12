. ./scripts/load_env.ps1

Write-Host "Container app deployed at: $env:SERVICE_APP_URI"

if (-not $env:AZURE_USE_AUTHENTICATION) {
    Exit 0
}


$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
  # fallback to python3 if python not found
  $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue
}

Start-Process -FilePath ($pythonCmd).Source -ArgumentList "./scripts/auth_update.py" -Wait -NoNewWindow
