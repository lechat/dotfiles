alias sudp='nocorrect sudo'
alias ncim='nocorrect nvim'
alias ls-al='nocorrect ls -al'
alias rsync='noglob rsync'
alias docker='podman'
alias dicker='podman'
alias grep='grep -E --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,vendor,.terraform} --exclude=tags'
alias pygrep='grep -r --include="*.py"'
alias ktx='kubectx'
alias kns='kubens'
alias kgn='kubectl get ns'
alias vimdiff='nvim -d'
alias sts=~/.local/bin/sts_eks.sh
alias stsadm=~/.local/bin/sts_eks_admin.sh
alias eks=~/.local/bin/eks.sh
alias replace-infra=~/.local/bin/replace_infra.sh

#CA_BUNDLE=$HOME/SCB-bundle.crt
CA_BUNDLE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
export AWS_CA_BUNDLE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
ACC_HK=533746428624
ACC_SG=373893023700
export BANKID="2007382"
export SSO_PASSWORD=$(cat $HOME/.creds)
export SSO_PWD=$SSO_PASSWORD
ZONE_ACC="o.2007382"

function kl {
    kubectl $@ -o yaml | less
}

function clusters() {
    local REGION=${1-"sg"}
    if [ $REGION = "sg" ]; then
        REGION="ap-southeast-1"
    fi
    if [ $REGION = "hk" ]; then
        REGION="ap-east-1"
    fi
    echo aws --ca-bundle $CA_BUNDLE eks list-clusters --region $REGION $@
    aws --ca-bundle $CA_BUNDLE eks list-clusters --region $REGION
}

function ekslogin() {
    local AREGION
    if [ -z $1 ]; then
        echo "Usage:"
        echo
        echo "ekslogin CLUSTER [-r REGION] [--nosts]"
        echo
        echo "Region names: hk,sg default: sg"
    else
        RUN_STS="runsts"
        while [[ $# -gt 0 ]]; do
            case $1 in
                --nosts)
                    RUN_STS="nosts"
                    shift # past argument
                    ;;
                -r|--region)
                    AREGION="$2"
                    shift # past argument
                    shift # past value
                    ;;
                *)
                    CLUSTER="$1"
                    shift # past argument
                    ;;
            esac
        done
        AREGION=${AREGION-"sg"}

        if [ $RUN_STS = "runsts" ]; then
            echo sts $AREGION Admin
            sts $AREGION Admin
        fi

        if [ $AREGION = "sg" ]; then
            AREGION="ap-southeast-1"
        fi
        if [ $AREGION = "hk" ]; then
            AREGION="ap-east-1"
        fi

        echo aws --ca-bundle $CA_BUNDLE eks update-kubeconfig --name "$CLUSTER" --region $AREGION --alias $CLUSTER
        aws --ca-bundle $CA_BUNDLE eks update-kubeconfig --name "$CLUSTER" --region $AREGION --alias $CLUSTER
        kubens kube-system
    fi
}

function urldecode() { : "${*//+/ }"; echo -e "${_//%/\\x}"; }

