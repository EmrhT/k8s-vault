#!/bin/bash

# Directory where encrypted kubeconfig files are stored
KUBECONFIG_DIR="$HOME/.kube/encrypted"
DECRYPTED_FILE="/tmp/kubeconfig"

# Function to list available kubeconfig files
function list_configs() {
  echo "Available kubeconfigs:"
  ls "$KUBECONFIG_DIR" | sed 's/.enc$//'
}

# Function to decrypt and use a kubeconfig file
function use_kubeconfig() {
  local name=$1
  local encrypted_file="$KUBECONFIG_DIR/$name.enc"

  if [[ ! -f "$encrypted_file" ]]; then
    echo "Error: Encrypted kubeconfig '$name' not found!"
    exit 1
  fi

  # Prompt for the password to decrypt the file
  echo "Enter password to decrypt $name:"
  openssl aes-256-cbc -pbkdf2 -d -in "$encrypted_file" -out "$DECRYPTED_FILE" || {
    echo "Failed to decrypt $name. Exiting."
    exit 1
  }

  # Export the decrypted kubeconfig for use
  export KUBECONFIG="$DECRYPTED_FILE"
  echo "Using kubeconfig: $DECRYPTED_FILE"

  # Start a new shell session to run kubectl commands
  echo "Run 'kubectl' commands as needed. Type 'exit' to clean up."
  bash --norc

  # Clean up the decrypted file
  unset KUBECONFIG
  rm -f "$DECRYPTED_FILE"
  echo "Decrypted kubeconfig cleaned up."
}

# Command-line interface
case $1 in
  list)
    list_configs
    ;;
  use)
    use_kubeconfig $2
    ;;
  *)
    echo "Usage: $0 {list|use <kubeconfig-name>}"
    ;;
esac
