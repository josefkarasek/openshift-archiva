#!/bin/bash

until curl -output /dev/null --silent --head --fail localhost:8080 > /dev/null; do
	sleep 2
done

curl -H "Content-Type: application/json" -X POST -d '{"username":"admin","password":"'"$ADMIN_PASSWORD"'","confirmPassword":"'"$ADMIN_PASSWORD"'","fullName":"administrator","email":"'"$ADMIN_EMAIL"'","validated":true,"assignedRoles":[],"modified":true,"rememberme":false,"logged":false}' http://localhost:8080/restServices/redbackServices/userService/createAdminUser > /dev/null 2>&1

echo "Administrator account created."