#!/bin/bash
# ROOT CA
openssl genrsa -out ssl/root-ca-key.pem 2048
openssl req -new -x509 -sha256 -key ssl/root-ca-key.pem -out ssl/root-ca.pem -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=CA ROOT"
# Admin cert
openssl genrsa -out ssl/admin-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in ssl/admin-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ssl/admin-key.pem
openssl req -new -key ssl/admin-key.pem -out ssl/admin.csr -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=ADMIN"
openssl x509 -req -in ssl/admin.csr -CA ssl/root-ca.pem -CAkey ssl/root-ca-key.pem -CAcreateserial -sha256 -out ssl/admin.pem
# Nodes certs
# Node 1
openssl genrsa -out ssl/node1-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in ssl/node1-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ssl/node1-key.pem
openssl req -new -key ssl/node1-key.pem -out ssl/node1.csr -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=node1.example.com"
openssl x509 -req -in ssl/node1.csr -CA ssl/root-ca.pem -CAkey ssl/root-ca-key.pem -CAcreateserial -sha256 -out ssl/node1.pem
# Node 2
openssl genrsa -out ssl/node2-key-temp.pem 2048
openssl pkcs8 -inform PEM -outform PEM -in ssl/node2-key-temp.pem -topk8 -nocrypt -v1 PBE-SHA1-3DES -out ssl/node2-key.pem
openssl req -new -key ssl/node2-key.pem -out ssl/node2.csr -subj "/C=CA/ST=ONTARIO/L=TORONTO/O=ORG/OU=UNIT/CN=node2.example.com"
openssl x509 -req -in ssl/node2.csr -CA ssl/root-ca.pem -CAkey ssl/root-ca-key.pem -CAcreateserial -sha256 -out ssl/node2.pem
# Cleanup
rm ssl/admin-key-temp.pem
rm ssl/admin.csr
rm ssl/node1-key-temp.pem
rm ssl/node1.csr
rm ssl/node2-key-temp.pem
rm ssl/node2.csr