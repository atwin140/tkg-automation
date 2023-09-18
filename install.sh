#!/bin/bash
# Install common utils
source /tmp/install.sc
set -eou pipefail

# Define default path for apps to be installed in

BIN_PATH="/usr/local/bin"
PATH=$PATH:$BIN_PATH

# Application versions definition for future updating
KUBECTL_VERSION='v1.24.14'
YQ_VERSION='v4.34.2'
# TANZU_VERSION='v0.12.1'
PINNIPED_VERSION='v0.24.0'
KAPP_VERSION="v0.57.1"
KBLD_VERSION="v0.37.4"
IMAGPK_VERSION="v0.37.2"
YTT_VERSION="v0.45.3"
VENDIR_VERSION="v0.32.2"
KAPP_CONTROLLER_VERSION="v0.44.1"
VAULT_VERSION="v1.13.0"

install_kubectl
install_tmc
install_kubeseal
install_helm_cli
install_terraform
install_carvel_tools
install_kubectl_vsphere
install_yq
install_kubens
# install_minio
install_pinniped
# install_kpack_cli
install_tanzu
#install_vault

rm -rf /tmp/*
