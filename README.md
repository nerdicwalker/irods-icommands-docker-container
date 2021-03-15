# irods-icommands-docker-container


# usage

# prerequisite
Create an .env file and store it in the root of the repo.
example .env file:
```
cat << EOF > .env
export irods_host="irods host name"
export irods_port="port number"
export irods_home="/your/irods/home"
export irods_user_name="your username"
export irods_zone_name="the irods zone"
export irods_authentication_scheme="authentication scheme"
export irods_encryption_algorithm="irods encryption algorithm"
export irods_encryption_key_size="irods encryption key size"
export irods_encryption_num_hash_rounds="irods encryption num hash rounds"
export irods_encryption_salt_size="irods encryption salt size"
export irods_client_server_negotiation="client server negotiation"
EOF
```

# deploy
start `./deploy.sh`

# icommands
start with `iinit` to connect to iRODS!



