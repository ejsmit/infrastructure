#!/bin/bash


if [ $# -ne 3 ];
    then echo "illegal number of parameters"
    echo "encrypt-file  variable filename destination"
    echo "encrypt-file  ssl_root_certificate ~/ca.key.pem vault_var/rootca-ssl.yml"
    exit 1
fi


echo "$1: '$2' in $3"
read -p "Press enter to continue"

echo "$1_name: `basename $2`"  >> $3
cat $2 |  ansible-vault encrypt_string  --stdin-name $1   >> $3
