#!/bin/bash

# Set your values
read -p "Enter your GitHub username: " GITHUB_USERNAME
read -p "Enter your GitHub personal access token: " GITHUB_PERSONAL_ACCESS_TOKEN
read -p "Enter your encrypt secret key: " ENCRYPT_SECRET_KEY
USE_PROFILE="prod"

# Create or update the ConfigMap
cat <<EOF > "service/config/config-local.yml"
apiVersion: v1
kind: ConfigMap
metadata:
  name: config-env
  namespace: prod
data:
  GITHUB_USERNAME: "$GITHUB_USERNAME"
  GITHUB_PERSONAL_ACCESS_TOKEN: "$GITHUB_PERSONAL_ACCESS_TOKEN"
  ENCRYPT_SECRET_KEY: "$ENCRYPT_SECRET_KEY"
  USE_PROFILE: "$USE_PROFILE"
EOF
