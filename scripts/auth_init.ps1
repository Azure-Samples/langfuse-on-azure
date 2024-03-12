Write-Host "Checking if authentication should be setup..."

. ./scripts/load_env.ps1

if (-not $env:AZURE_USE_AUTHENTICATION) {
    Write-Host "AZURE_USE_AUTHENTICATION is not set, skipping authentication setup."
    Exit 0
}

$pythonCmd = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCmd) {
  # fallback to python3 if python not found
  $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue
}

Start-Process -FilePath ($pythonCmd).Source -ArgumentList "./scripts/auth_init.py" -Wait -NoNewWindow
