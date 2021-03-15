#/bin/bash

# read the .env file
source .env

# check if required environment variables are available
iRODSHost=${irods_host?"Please declare environment variable: 'irods_host'."}
iRODSPort=${irods_port?"Please declare environment variable: 'irods_port'."}
iRODSHome=${irods_home?"Please declare environment variable: 'irods_home'."}
iRODSUserName=${irods_user_name?"Please declare environment variable: 'irods_user_name'."}
iRODSZoneName=${irods_zone_name?"Please declare environment variable: 'irods_zone_name'."}
iRODSAuthenticationScheme=${irods_authentication_scheme?"Please declare environment variable: 'irods_authentication_scheme'."}
iRODSEncryptionAlgorithm=${irods_encryption_algorithm?"Please declare environment variable: 'irods_encryption_algorithm'."}
iRODSEncryptionKeySize=${irods_encryption_key_size?"Please declare environment variable: 'irods_encryption_key_size'."}
iRODSEncryptionNumHashRounds=${irods_encryption_num_hash_rounds?"Please declare environment variable: 'irods_encryption_num_hash_rounds'."}
iRODSEncryptionSaltSize=${irods_encryption_salt_size?"Please declare environment variable: 'irods_encryption_salt_size'."}
iRODSClientServerNegotiation=${irods_client_server_negotiation?"Please declare environment variable: 'irods_client_server_negotiation'."}

# creating irods_environment.json file
cat << EOF > irods_environment.json
{
    "irods_host": "$iRODSHost",
    "irods_port": $iRODSPort,
    "irods_home": "$iRODSHome",
    "irods_user_name": "$iRODSUserName",
    "irods_zone_name": "$iRODSZoneName",
    "irods_authentication_scheme": "$iRODSAuthenticationScheme",
    "irods_encryption_algorithm": "$iRODSEncryptionAlgorithm",
    "irods_encryption_key_size": $iRODSEncryptionKeySize,
    "irods_encryption_num_hash_rounds": $iRODSEncryptionNumHashRounds,
    "irods_encryption_salt_size": $iRODSEncryptionSaltSize,
    "irods_client_server_negotiation": "$iRODSClientServerNegotiation"
}
EOF

# building docker container
echo "Building container.."
docker image build -t ubuntu-1604-icommands . 
rm -rf irods_environment.json

echo "Starting container.."
# start docker container
docker container run --name iRODS-icommands --detach ubuntu-1604-icommands:latest tail -f /dev/null

echo "Connecting to the container.."
# connecting docker container
docker run -it ubuntu-1604-icommands:latest bash

echo "Stoping the container.."
# stopping docker container
docker container stop iRODS-icommands

# cleaning up 
echo "Removing container.."
docker container rm --force iRODS-icommands
echo "Removing image.."
docker image rm --force ubuntu-1604-icommands