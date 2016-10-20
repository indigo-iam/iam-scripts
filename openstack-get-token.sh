#!/bin/bash

if [[ -z ${IAM_USER} ]]; then
  read -p "Username: " IAM_USER
fi

echo -ne "Password:"
read -s IAM_PASSWORD
echo

openstack --debug \
    --os-auth-url https://keystone.ifca.es:5000/v3 \
    --os-auth-type v3oidcpassword \
    --os-identity-provider indigo-dc \
    --os-protocol oidc \
    --os-project-name VO:indigo \
    --os-project-domain-id default \
    --os-identity-api-version 3 \
    --os-client-id ${IAM_CLIENT_ID} \
    --os-client-secret ${IAM_CLIENT_SECRET} \
    --os-discovery-endpoint https://iam-test.indigo-datacloud.eu/.well-known/openid-configuration \
    --os-openid-scope "openid profile email" \
    --os-username ${IAM_USER} \
    --os-password ${IAM_PASSWORD} \
    token issue
