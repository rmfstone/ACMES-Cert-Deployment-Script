#!/usr/bin/env bash
# Made by a Stone

# Sources

main() {
  check_acme
  set_env_variables
}


check_acme() {
  if ! [ -d "$HOME/.acme.sh" ]; then
    echo "ACME is not installed, run te install script first!"
    exit 1
}

set_env_variables() {
  echo "Set the env variables for your DNS api access"
  echo "Choose your DNS api provider from the followinf list!"
  echo "IONOS (i) \n Cloudflare (c) \n Google cloud DNS (g) \n Route 53 (r)"
  read -p "Enter Provider: " provider


  #read -p "Enter Prefix: " prefix
  #read -p "Enter Secret: " secret
  


  #export ISSUER_PREFIX="$prefix"
  #export ISSUER_SECRET="$secret"
}
