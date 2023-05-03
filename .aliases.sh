alias sudp='nocorrect sudo'
alias ls-al='nocorrect ls -al'
alias rsync='noglob rsync'
alias docker='podman'
alias dicker='podman'
alias grep='grep -E --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,vendor} --exclude=tags'
alias pygrep='grep -r --include="*.py"'
alias ktx='kubectx'
alias kns='kubens'
alias kgn='kubectl get ns'
alias vimdiff='nvim -d'

#CA_BUNDLE=$HOME/SCB-bundle.crt
CA_BUNDLE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
export AWS_CA_BUNDLE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
ACC_HK=533746428624
ACC_SG=373893023700
export BANKID="2007382"
export SSO_PASSWORD=$(cat $HOME/.login)
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

function sts() {
    if [ -z $1 ]; then
        echo "Usage:"
        echo
        echo "sts REGION [--role ROLE] [--skip-prompt]"
        echo
        echo "Region names: hk,sg default: sg"
    else
        local region=${1-"sg"}

        if [ $region = "sg" ]; then
            ACCOUNT=$ACC_SG
        fi
        if [ $region = "hk" ]; then
            ACCOUNT=$ACC_HK
        fi

        [ -z $SSO_PASSWORD ] && export SSO_PASSWORD=$(cat $HOME/.login)

        echo gettoken --awsAccount $ACCOUNT --roleName $role
        gettoken --awsAccount $ACCOUNT --roleName $role
        # aws-sts login --hostname sts01.internal.sc.com -u "zone1-scbnet\o.$BANKID" -a $ACCOUNT $@
        clusters $REGION
    if [ $REGION = "lon" ]; then
        REGION="eu-west-2"
    fi
    echo aws --ca-bundle $CA_BUNDLE eks list-clusters --region $REGION
    aws --ca-bundle $CA_BUNDLE eks list-clusters --region $REGION | tee
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

function eks() {
    local AREGION="sg"
    if [ -z $1 ]; then
        echo "Usage:"
        echo
        echo "eks CLUSTER [-r REGION]"
        echo
        echo "Region names: hk,sg default: sg"
    else
        while [[ $# -gt 0 ]]; do
            case $1 in
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

        if [ $AREGION = "sg" ]; then
            AREGION="ap-southeast-1"
        fi
        if [ $AREGION = "hk" ]; then
            AREGION="ap-east-1"
        fi
        if [ $AREGION = "lon" ]; then
            AREGION="eu-west-2"
        fi

        echo aws --ca-bundle $CA_BUNDLE eks update-kubeconfig --name "$CLUSTER" --region $AREGION --alias $CLUSTER
        aws --ca-bundle $CA_BUNDLE eks update-kubeconfig --name "$CLUSTER" --region $AREGION --alias $CLUSTER
        kubens kube-system
    fi
}

function tonysg() {
    gettoken --awsAccount 574229855744 --roleName PubCloud_All_AWSOpr
    clusters
    ekslogin "internalapiga-nonprod-ap-southeast-1-eks-01" --nosts
}

function sebastian() {
    gettoken --awsAccount 539572264133  --roleName PubCloud_All_AWSOpr
    ekslogin "foundationserv-nonprod-ap-southeast-1-eks-eks-01" --nosts
}
