#!/bin/bash

# start jy-auth-server
# start jy-web

url="web:123456@localhost:8083/api/oauth/token" 
data="grant_type=password&username=huang&password=123456&scope=account"
json=`curl -s -XPOST $url -d $data`
echo $json
access_token=`echo $json | jq '.access_token' | sed 's/\"//g'`

echo $access_token
curl -H "Authorization: Bearer $access_token" -XGET http://localhost:8083/api/account/user/info
echo 
#sleep 1
curl -H 'Content-Type: application/json' -H "Authorization: Bearer $access_token" -XPOST http://localhost:8081/api/approval/token
