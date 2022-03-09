#!/bin/sh


if [ $# -ne 3 ];
    then echo "illegal number of parameters"
    echo "encrypt-var  variable value target_file"
    echo "encrypt-password  foo bar vault_vars/foo.local.yml"
    exit 1
fi


echo "$1: '$2' in $3"


ansible-vault encrypt_string --encrypt-vault-id ejsmit "$2" --name $1   >> $3
