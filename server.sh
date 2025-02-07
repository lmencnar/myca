#!/bin/bash

export CERTCN=localhost
export PASS=password

echo $CERTCN
echo $PASS

openssl req -new -newkey rsa:2048 -nodes -subj "/C=CH/CN=$CERTCN" -addext "subjectAltName = DNS:$CERTCN" -keyout $CERTCN.key -out $CERTCN.csr
openssl x509 -req -in $CERTCN.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -extfile <(printf "subjectAltName=DNS:$CERTCN") -out $CERTCN.crt -days 5000 -sha256

cat $CERTCN.crt rootCA.crt > $CERTCN.bundle.crt

echo $PASS > $CERTCN.pwd

openssl pkcs12 -export -out $CERTCN.p12 -inkey $CERTCN.key -in $CERTCN.crt -certfile rootCA.crt -passout file:$CERTCN.pwd

openssl x509 -in $CERTCN.crt -text

openssl pkcs12 -info -in $CERTCN.p12 -nodes -passin file:$CERTCN.pwd

