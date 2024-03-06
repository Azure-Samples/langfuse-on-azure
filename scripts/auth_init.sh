 #!/bin/sh

echo "Checking if authentication should be setup..."

. ./scripts/load_env.sh

if [ -z "$AZURE_USE_AUTHENTICATION" ]; then
  echo "AZURE_USE_AUTHENTICATION is not set, skipping authentication setup."
  exit 0
fi

python ./scripts/auth_init.py