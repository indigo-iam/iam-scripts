#!/bin/bash

if [[ -z ${IAM_ACCESS_TOKEN} ]]; then
  echo "Please set the IAM_ACCESS_TOKEN so that it points to an IAM access token."
  exit 1
fi

userinfo=$(curl -s -L -H "Authorization: Bearer ${IAM_ACCESS_TOKEN}" ${IAM_USERINFO_ENDPOINT:-https://iam-test.indigo-datacloud.eu/userinfo})

if [[ $? != 0 ]]; then
  echo "Error!"
  echo $userinfo
  exit 1
fi

echo $userinfo | jq .
