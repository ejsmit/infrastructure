#!/bin/sh

# generates both password and hash.  Delete the one you dont want.  In some
# places you need the actual password, and other can work with a hash.

if [ $# -ne 3 ];
    then echo "illegal number of parameters"
    echo "encrypt-password  username password target_file"
    echo "encrypt-password  foo bar vault_vars/foo.local/main.yml"
    exit 1
fi


echo "$1: '$2' in $3"

hash=`mkpasswd -m sha-512 $2`

ansible-vault encrypt_string "$hash" --name $1_password_hash  >> $3

ansible-vault encrypt_string "$2" --name $1_password  >> $3
