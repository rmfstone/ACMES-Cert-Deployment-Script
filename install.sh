#!/usr/bin/env bash
# Made by a Stone

main() {
  check_root
  check_curl_installed
  check_acme_installed
}

# Check if user is root
check_root() {
  if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
  else
    echo "Root check successfully!"
  fi
}

# Check if curl is installed
check_curl_installed() {
  if ! command -v curl >/dev/null 2>&1; then
    echo "Curl is not installed!"
    read -p "Do you want to install curl now? (y/n): " install_curl
    if [[ "$install_curl" =~ [Yy] ]]; then
      echo "Installing curl..."
      sudo apt update
      sudo apt install -y curl

      if command -v curl >/dev/null 2>&1; then
        echo "Curl installed successfully!"
      else
        echo "Failed to install curl!"
        echo "Exiting..."
        exit 1
      fi
    fi
  fi
}

# Check if ACME is already installed
check_acme_installed() {
  if [ -d "$HOME/.acme.sh" ]; then
    echo "ACME seems to have already been installed into /root!"
    echo "Check the folder and either remove it or skip this install step."

    read -p "Skip ACME installation? (y/n): " skip_acme_install
    read -p "Want to delete ACME to reinstall it? (y/n): " acme_rm
    if [[ ! "$skip_acme_install" =~ [Yy] ]]; then
      echo "Installing ACME"
      curl https://get.acme.sh | sh
    elif [[ "$acme_rm" =~ [Yy] ]]; then
      echo "Installing ACME"
      rm -rf "$HOME"/.acme.sh
      curl https://get.acme.sh | sh
    fi
  else
    echo "ACME not detected — installing..."
    sudo apt install chron
    curl https://get.acme.sh | sh
  fi
}

main "$@"
