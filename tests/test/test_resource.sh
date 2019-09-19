#!/bin/bash

# start jy-auth-server
# start jy-web

url="web:123456@localhost:8083/oauth/token" 
data="grant_type=password&username=huang&password=123456&scopes=account"
json=`curl -s -XPOST $url -d $data`
echo $json
access_token=`echo $json | jq '.access_token' | sed 's/\"//g'`

#access_token="eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiYXBpcyJdLCJ1c2VyX25hbWUiOiJodWFuZyIsInNjb3BlIjpbImFjY291bnQiXSwiZXhwIjoxNTQzMTk4NzExLCJhdXRob3JpdGllcyI6WyJST0xFX1VTRVIiXSwianRpIjoiMzdjNDVjNTItNzIzOC00NzEyLWExNDYtNzI0ZTg3YzM1NzdlIiwiY2xpZW50X2lkIjoid2ViIn0.ZPgUAGchZOtvPfdzh4pMSFg64Jzh_0pD87qnoLxCxPvCkYMvx8nebj6VS2lXBxODC_6Ew8jD3pBG1qlqy8wIQ0k339XQ_2-GnlK273W-9mR4INWbLhyWIcO3I9u1wBJQE_y8dr6y0-1me2k71xi9lkHkIwmA7Hf6ycbURH74WBgzDFxFXRUnv3rG427YWkdItdAfHtw5vJ7EYYtW84ii4sqnvhXjABaymPuph8K3UtOPF_lDkTDxWe1vX2oZI9ujS2PwGEY8I08LBuA56oE7JUTix4qhWHh5njok6HtK1TspQXKHha4Shf-1eqSfSN5ScuHHHQ7T0nTxwu4zmIIzXw"

curl -vvv -H "Authorization: Bearer $access_token" -XGET http://localhost:8081/p/1
