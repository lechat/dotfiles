#!/bin/bash

source ~/.aliases.sh

sts () {
	local account=$1
    shift 1
	local role="PubCloud_All_AWSOpr"
	local cluster=""
    local region="sg"
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
		echo gettoken --awsAccount $account --roleName $role --region $region
		gettoken --awsAccount $account --roleName $role
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
