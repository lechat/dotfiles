#!/bin/bash

source ~/.aliases.sh

sts () {
	local account=$1
    shift 1
	local role="Admin"
	local cluster=""
    local REGION="sg"
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
				(-r | --region) REGION="$2"
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
		if [ "$REGION" = "sg" ]
		then
			REGION=ap-southeast-1
		fi
		if [ "$REGION" = "hk" ]
		then
			REGION=ap-east-1
		fi
		if [ "$REGION" = "lon" ]
		then
			REGION=eu-west-2
		fi
		[ -z $SSO_PASSWORD ] && export SSO_PASSWORD=$(cat $HOME/.login)
        echo "Attempting to login to account $account with role $role"
        echo aws-auth-token login --force --role $role --account $account --username $ldap --credential-process
        aws-auth-token login --force --role $role --account $account --username $ldap --credential-process
        if [ "$?" != "0" ]; then
            echo "Cannot assume role"
            exit 1
        fi
        ACCESS_KEY_ID=$(echo "$JSON_CREDS" | jq -r '.AccessKeyId')
        SECRET_ACCESS_KEY=$(echo "$JSON_CREDS" | jq -r '.SecretAccessKey')
        SESSION_TOKEN=$(echo "$JSON_CREDS" | jq -r '.SessionToken')
        EXPIRATION=$(echo "$JSON_CREDS" | jq -r '.Expiration')
        cat << EOF > $HOME/.aws/credentials
[default]
output                   = json
REGION                   = $REGION
aws_access_key_id        = $ACCESS_KEY_ID
aws_secret_access_key    = $SECRET_ACCESS_KEY
aws_session_token        = $SESSION_TOKEN
aws_security_token       = $SESSION_TOKEN
x_security_token_expires = $EXPIRATION

EOF
		if [ "$cluster" = "" ]
		then
            echo "aws --ca-bundle /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem eks list-clusters --REGION $REGION"
			opts=($(aws --ca-bundle /etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem eks list-clusters --REGION $REGION | jq -r '.clusters[]'))
			select opt in "${opts[@]}"
			do
			break
			done
			$HOME/.local/bin/eks.sh $opt -r $REGION
		else
			$HOME/.local/bin/eks.sh $cluster -r $REGION
		fi
	fi
}

sts $@
