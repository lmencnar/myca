#!/bin/bash

export PASS=password

echo $PASS

echo $PASS > rootCA.pwd

mydn="/C=CH/ST=State/L=City/O=org/OU=ou/"
mydn=${mydn}"CN=ca/emailAddress=user@gmail.com"

openssl req -newkey rsa:2048 -nodes -keyout rootCA.key -x509 -subj "${mydn}" -days 5000 -out rootCA.crt
openssl pkcs12 -export -out rootCA.p12 -in rootCA.crt -nokeys  -passout file:rootCA.pwd
openssl x509 -in rootCA.crt -text -noout 
