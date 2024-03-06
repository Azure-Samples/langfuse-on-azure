 #!/bin/sh

. ./scripts/load_env.sh

# Echo the value of SERVICE_APP_URI
echo "Container app deployed at: $SERVICE_APP_URI"

if [ -z "$AZURE_USE_AUTHENTICATION" ]; then
  exit 0
fi

python ./scripts/auth_update.py