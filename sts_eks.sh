#!/bin/bash

source ~/.aliases.sh

sts () {
	local account=$1
    shift 1
	local role="Admin"
	local cluster=""
    local region="sg"
    local ldap="o.aws.gf.dev.2007382@zone1.scb.net"

	if [ "$account" = "" ]
	then
		echo "Usage:"
		echo
		echo "sts ACCOUNT [-c CLUSTER] [-r REGION] [-u ROLE]"
		echo
		echo "ACCOUNT could be a number of project name. The project's accounts are stored in ~/eks"
		echo "Region names: hk,sg,lon default: sg"
		echo "Default role PubCloud_All_AWSOpr"
        echo
        echo "Available accounts:"
        ls ~/eks/
	else
		while [[ $# -gt 0 ]]
		do
			case $1 in
				(-r | --region) region="$2"
					shift
					shift ;;
				(-u | --user) role="$2"
					shift
					shift ;;
				(-l | --ldap) ldap="$2"
					shift
					shift ;;
				(-c | --cluster) cluster="$2"
					shift
					shift ;;
				(*) shift ;;
			esac
		done

		re='^[0-9]+$'
		if ! [[ $account =~ $re ]]
		then
			if [ -e ~/eks/$account ]
			then
				account=$(cat ~/eks/$account)
			else
				echo "There is no ~/eks/$account file"
                ls -al ~/eks/
                exit 1
			fi
		fi
		if [ "$region" = "sg" ]
		then
			region=ap-southeast-1
		fi
		if [ "$region" = "hk" ]
		then
			region=ap-east-1
		fi
		if [ "$region" = "lon" ]
		then
			region=eu-west-2
		fi
		[ -z $SSO_PASSWORD ] && export SSO_PASSWORD=$(cat $HOME/.login)
        echo "Attempting to login to account $account with role $role"
        echo aws-auth-token login --force --role $role --account $account --username $ldap
        aws-auth-token login --force --role $role --account $account --username $ldap
        if [ "$?" != "0" ]; then
            echo "Cannot assume role"
            exit 1
        fi
        #   if [ "$account" == "238634994034" ]; then
        #       echo $HOME/.local/bin/sts.exp $account
        #       $HOME/.local/bin/sts.exp $account $role
        #   else
        #       echo gettoken --awsAccount $account --roleName $role --region $region
        #       if gettoken --awsAccount $account --roleName $role; then
        #           echo
        #       else
        #           echo "Error getting SAML/STS auth"
        #           exit 1
        #       fi
        #   fi
        sed -i "s/eu-west-1/$region/g" ~/.aws/credentials
        sed -i "s/ap-east-1/$region/g" ~/.aws/credentials
		if [ "$cluster" = "" ]
		then
            echo "aws --ca-bundle /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem eks list-clusters --region $region"
			opts=($(aws --ca-bundle /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem eks list-clusters --region $region | jq -r '.clusters[]'))
			select opt in "${opts[@]}"
			do
			break
			done
			$HOME/.local/bin/eks.sh $opt -r $region
		else
			$HOME/.local/bin/eks.sh $cluster -r $region
		fi
	fi
}

sts $@
