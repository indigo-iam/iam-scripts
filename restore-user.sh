#!/bin/bash

source .env

uuid=${RESTORE_USER_UUID}
admin_token=${RESTORE_USER_ADMIN_TOKEN}
iam_host=${RESTORE_USER_IAM_HOSTNAME}

echo ""
if [ -z "$uuid" ]
  then
    echo "No User UUID supplied"
fi
echo "User UUID: $uuid";

if [ -z "$admin_token" ]
  then
    echo "No bearer token found"
fi
echo "Bearer token: found";

if [ -z "$iam_host" ]
  then
    echo "No IAM host found"
fi
echo "IAM hostname: $iam_host";
echo ""

curl_settings='-o /dev/null -s -w "%{http_code}"'

echo "Deleting label lifecycle.status ..."
code=$(curl ${curl_settings} -X DELETE -H "Authorization: Bearer ${admin_token}" -H "Content-Type: application/x-www-form-urlencoded" -d 'name=lifecycle.status' https://$iam_host/iam/account/${uuid}/labels)
echo ${code}
echo "Deleting label lifecycle.timestamp ..."
code=$(curl ${curl_settings} -X DELETE -H "Authorization: Bearer ${admin_token}" -H "Content-Type: application/x-www-form-urlencoded" -d 'name=lifecycle.timestamp' https://$iam_host/iam/account/${uuid}/labels)
echo ${code}
echo "Setting endTime null ..."
code=$(curl ${curl_settings} -X PUT -H "Authorization: Bearer ${admin_token}" -H "Content-Type: application/json" -d '{"endTime":""}' https://$iam_host/iam/account/${uuid}/endTime)
echo ${code}
echo "Enabling user ..."
code=$(curl ${curl_settings} -X PATCH -H "Authorization: Bearer ${admin_token}" -H "Content-Type: application/scim+json;charset=UTF-8" --data-binary "@patchEnableUser.json" https://$iam_host/scim/Users/${uuid})
echo ${code}
echo "User restored."