#!/bin/bash
# Install common utils
## source /tmp/install.sc
set -eou pipefail
echo "Start---------------------------------------------------"
# Define default path for apps to be installed in

BIN_PATH="/usr/local/bin"
PATH=$PATH:$BIN_PATH

# Application versions definition for future updating
KUBECTL_VERSION='v1.32.2'
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

## curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

install_kubectl
# install_tmc
install_kubeseal
install_helm_cli
install_terraform
# install_carvel_tools
# install_kubectl_vsphere
install_yq
install_kubens
# install_minio
# install_pinniped
# install_kpack_cli
# install_tanzu
#install_vault

rm -rf /tmp/*







#################
### Functions ###
#################

# Install common utils
function install_kubectl() {
    KUBECTL_PATH=$BIN_PATH/kubectl

    if [[ -f $KUBECTL_PATH ]]; then
        echo "Kubectl is already installed!"
    else
        echo "Installing kubectl with version ${KUBECTL_VERSION}"
            curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
            sleep 3
            chmod +x ./kubectl
            mv ./kubectl $BIN_PATH
            type kubectl
            echo 'source <(kubectl completion bash)' >> ~/.bash_profile
       fi
}


function install_kubeseal() {
    KUBESEAL_PATH=/usr/local/bin/kubeseal
    if [[ -f $KUBESEAL_PATH ]]; then
        echo "Kubeseal are installed"
    else
        echo "Installing Kubeseal"
        cd /tmp
        tar -xvzf kubeseal.tar.gz kubeseal
        install -m 755 kubeseal /usr/local/bin/kubeseal
        type kubeseal
    fi
}



function install_kubens() {
    KUBESEAL_PATH=/usr/bin/kubens
    if [[ -f $KUBESEAL_PATH ]]; then
        echo "Kubens are installed"
    else
        echo "Installing Kubens"
        mkdir -p 700 /home/testuser/.kube
        chown testuser:testuser /home/testuser/.kube
        cd /tmp
        git clone https://github.com/ahmetb/kubectx /opt/kubectx
        ln -s /opt/kubectx/kubectx /usr/bin/kubectx
        ln -s /opt/kubectx/kubens /usr/bin/kubens
        chmod +x kube-ps1.sh
        mv kube-ps1.sh /usr/bin/kube-ps1.sh
        echo "

        alias k=kubectl

        # Kube-ps
        source /usr/bin/kube-ps1.sh
        PS1='[\u@ \W \$(kube_ps1)\\\$ '
        export KUBE_PS1_SYMBOL_COLOR=cyan
        export KUBE_PS1_CTX_COLOR=green
        export KUBE_PS1_SEPARATOR=' - '
        export KUBE_PS1_PREFIX=' |'
        export KUBE_PS1_SUFFIX='| '
        " >> /home/testuser/.bashrc
        type kubens
    fi
}



function install_tmux() {
    TMUX_PATH=/usr/bin/tmux
    if [[ -f $NMAP_PATH ]]; then
        echo "tmux is installed"
    else
        echo "Installing tmux"
        apt-get install tmux
        type tmux
    fi
}





function install_tmc() {
    TMC_PATH=$BIN_PATH/tmc

    if [[ -f $TMC_PATH ]]; then
        echo "TMC is already installed!"
    else
        echo "Installing tmc"
            unzip /tmp/tmc.zip -d /tmp
            pwd
            chmod +x /tmp/tmc
            mv /tmp/tmc $BIN_PATH
            type tmc
       fi
}

function install_tmux() {
    TMUX_PATH=$BIN_PATH/tmux

    if [[ -f $KUBECTL_PATH ]]; then
        echo "tmux is already installed!"
    else
        echo "Installing tmux "
        git clone https://github.com/tmux/tmux.git
        cd tmux
        sh autogen.sh
        ./configure
        make && sudo make install
       fi
}


function install_helm_cli {
    HELM_PATH=$BIN_PATH/helm

    if [[ -f $HELM_PATH ]]; then
        echo "Helm is already installed!"
    else
        echo -en "Installing latest Helm version 3.   -----  "
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
        chmod 700 get_helm.sh
        ./get_helm.sh
        rm -f ./get_helm.sh
        type helm
    fi
}

function install_terraform() {
    TERRAFORM_PATH=$BIN_PATH/terraform

    if [[ -f $TERRAFORM_PATH ]]; then
        echo "terraform is already installed!"
    else
        echo "Installing terraform with version 1.0.8"
        echo "Installing  terraform..."
        curl -fsSL -o terraform.zip https://releases.hashicorp.com/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip
        unzip terraform.zip
        chmod +x terraform
        mv terraform $BIN_PATH
        rm terraform.zip
    fi

}


function install_carvel_tools() {
    YTT_PATH=$BIN_PATH/ytt
    if [[ -f $YTT_PATH ]]; then
        echo "Carvel Tools are already installed!"
    else
        echo "-----"
        echo "Carvel Tools are installing"
        echo "   Downloading Ytt"
        curl -fsSL -o /tmp/ytt https://github.com/vmware-tanzu/carvel-ytt/releases/download/${YTT_VERSION}/ytt-linux-amd64
        # echo "   Downloading imgpkg"
        # curl -fsSL -o /tmp/imgpkg https://github.com/vmware-tanzu/carvel-imgpkg/releases/download/${IMAGPK_VERSION}/imgpkg-linux-amd64
        # echo "   Downloading kbld"
        # curl -fsSL -o /tmp/kbld https://github.com/vmware-tanzu/carvel-kbld/releases/download/${KBLD_VERSION}/kbld-linux-amd64
        echo "   Downloading kapp"
        curl -fsSL -o /tmp/kapp https://github.com/vmware-tanzu/carvel-kapp/releases/download/${KAPP_VERSION}/kapp-linux-amd64
        # echo "   Downloading vendir"
        # curl -fsSL -o /tmp/vendir https://github.com/vmware-tanzu/carvel-vendir/releases/download/${VENDIR_VERSION}/vendir-linux-amd64
        # echo "   Downloading kctrl"
        # curl -fsSL -o /tmp/kctrl https://github.com/vmware-tanzu/carvel-kapp-controller/releases/download/${KAPP_CONTROLLER_VERSION}/kctrl-linux-amd64


        dst_dir="${K14SIO_INSTALL_BIN_DIR:-/usr/local/bin}"
        dl_bin="curl -s -L"
        binary_type=linux-amd64
        echo "   Installing ${binary_type} binaries..."


        echo " - Installing ytt..."
        #$dl_bin github.com/vmware-tanzu/carvel-ytt/releases/download/v0.43.0/ytt-${binary_type} > /tmp/ytt
        mv /tmp/ytt ${dst_dir}/ytt
        chmod +x ${dst_dir}/ytt
        echo "  Installed ${dst_dir}/ytt v0.43.0"
        echo $(ytt version)

        # echo " - Installing imgpkg..."
        # # $dl_bin github.com/vmware-tanzu/carvel-imgpkg/releases/download/v0.33.0/imgpkg-${binary_type} > /tmp/imgpkg
        # mv /tmp/imgpkg ${dst_dir}/imgpkg
        # chmod +x ${dst_dir}/imgpkg
        # echo "   Installed ${dst_dir}/imgpkg v0.33.0"
        # echo `imgpkg version`

        # echo " - Installing kbld..."
        # # $dl_bin github.com/vmware-tanzu/carvel-kbld/releases/download/v0.35.0/kbld-${binary_type} > /tmp/kbld
        # mv /tmp/kbld ${dst_dir}/kbld
        # chmod +x ${dst_dir}/kbld
        # echo "  Installed ${dst_dir}/kbld v0.35.0"
        # echo `kbld version`

        echo " - Installing kapp..."
        # $dl_bin github.com/vmware-tanzu/carvel-kapp/releases/download/v0.53.0/kapp-${binary_type} > /tmp/kapp
        mv /tmp/kapp ${dst_dir}/kapp
        chmod +x ${dst_dir}/kapp
        echo "   Installed ${dst_dir}/kapp v0.53.0"
        echo `kbld version`


        # echo " - Installing vendir..."
        # # $dl_bin github.com/vmware-tanzu/carvel-vendir/releases/download/v0.32.0/vendir-${binary_type} > /tmp/vendir
        # mv /tmp/vendir ${dst_dir}/vendir
        # chmod +x ${dst_dir}/vendir
        # echo "   Installed ${dst_dir}/vendir v0.32.0"
        # echo `vendir version`

        # echo " - Installing kctrl..."
        # # $dl_bin github.com/vmware-tanzu/carvel-kapp-controller/releases/download/v0.41.3/kctrl-${binary_type} > /tmp/kctrl
        # mv /tmp/kctrl ${dst_dir}/kctrl
        # chmod +x ${dst_dir}/kctrl
        # echo "   Installed ${dst_dir}/kctrl v0.41.3"
        # echo `kctrl version`
    fi
    # Verify that all of the tools are installed and working.
    ytt version && kapp version 
}

function install_kubectl_vsphere() {
    echo "Installing kubectl-vsphere plugin..."
    cd /tmp/

    if [ ! -f vsphere-plugin.zip ]; then
        echo "The archive 'vsphere-plugin.zip' not found! Please manually download this from vSphere."
        echo "https://docs.vmware.com/en/VMware-vSphere/7.0/vmware-vsphere-with-tanzu/GUID-0F6E45C4-3CB1-4562-9370-686668519FCA.html"
        exit 1
    fi

    unzip vsphere-plugin.zip
    mv /tmp/bin/kubectl-vsphere ${BIN_PATH}/
    rm vsphere-plugin.zip
}

function install_yq(){
    YQ_PATH=$BIN_PATH/yq
    if [[ -f $YQ_PATH ]]; then
        echo "YQ is already installed!"
    else
        echo "Installing yq..."
        BINARY=yq_linux_amd64
        curl -fsSL -o  ${BIN_PATH}/yq https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${BINARY}
        chmod +x ${BIN_PATH}/yq
        type yq
    fi
}

function install_pinniped(){
    PINNIPED_PATH=$BIN_PATH/pinniped
    if [[ -f $PINNIPED_PATH ]]; then
        echo "Pinniped is already installed!"
    else
        echo "Installing pinniped..."
        BINARY=pinniped-cli-linux-amd64
        curl -fsSL -o  ${BIN_PATH}/pinniped https://get.pinniped.dev/${PINNIPED_VERSION}/${BINARY}
        chmod +x ${BIN_PATH}/pinniped
        type pinniped
    fi
}

function install_minio() {
    MINIO_PATH=$BIN_PATH/mc
    if [[ -f $MINIO_PATH ]]; then
        echo "Minio is already installed!"
    else
    echo "Installing minio client..."
    curl -fsSL -o  ${BIN_PATH}/mc https://dl.minio.io/client/mc/release/linux-amd64/mc
    chmod +x ${BIN_PATH}/mc
    type mc
    fi
}

function install_tanzu() {
    TANZU_PATH=$BIN_PATH/tanzu
    if [[ -f $TANZU_PATH ]]; then
        echo "TANZU is already installed!"
    else
        echo "Installing tanzu-cli..."

        mkdir -p /tmp
        cd /tmp
        sudo install /tmp/tanzu-core-linux_amd64 /usr/local/bin/tanzu
        rm /tmp/tanzu-core-linux_amd64

        # export TANZU_API_TOKEN="OTuZ5IndbgaesA4-erPrKzW5t8q5QQ40oOhv4rS5bamL9AqINPEWpo86oFIlvN8D"
        # tanzu context create --endpoint "dellemccompute20.tmc.cloud.vmware.com/" --name tmc
        # tanzu init
                
    type tanzu
    runuser -l testuser -c 'tanzu config  eula accept'
    runuser -l testuser -c 'tanzu ceip-participation set false'
    fi
}

function install_kpack_cli() {
    KP_PATH=$BIN_PATH/kp
    if [[ -f $KP_PATH ]]; then
        echo "Kpack is already installed!"
    else
        echo "Insatlling Kpack"
        mkdir -p /tmp/
        cd /tmp/
        curl -fsSL -o  ${BIN_PATH}/kp https://github.com/vmware-tanzu/kpack-cli/releases/download/v0.4.2/kp-linux-0.4.2
        chmod +x ${BIN_PATH}/kp
    type kp
    fi
}


function install_go() {
    GO_PATH=/usr/local/go
    if [[ -f $GO_PATH ]]; then
        echo "GO is already installed!"
    else
        echo "Installing GO"
        wget -qO- https://go.dev/dl/go1.17.3.linux-amd64.tar.gz | tar xfz - -C /usr/local
    fi
}











