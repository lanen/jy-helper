#!/bin/bash

url="web:123456@localhost:8083/api/oauth/token" 
data="grant_type=password&username=huang&password=123456&scope=account"
json=`curl -s -XPOST $url -d $data`
echo $json
access_token=`echo $json | jq '.access_token' | sed 's/\"//g'`

echo $access_token
w='{"approvalFor":1,"approvalScene": 1, "subjectId":1}'
#sleep 1
token=`curl -s -H "Authorization: Bearer $access_token" -H "Content-Type: application/json" -d "$w" -XPOST http://localhost:8081/api/approval/token`
echo $token
curl -H "Authorization: Bearer $access_token" \
	-H "Content-Type: application/json" \
	-d "$w"  \
	-XPUT http://localhost:8081/api/approval/$token

echo $token
curl -H "Authorization: Bearer $access_token" \
	-XPUT http://localhost:8081/api/approval/w/$token
