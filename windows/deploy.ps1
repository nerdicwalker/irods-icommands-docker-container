Set-ExecutionPolicy Unrestricted -force

# Input iRODS username
$iRODSUsername = Read-Host -Prompt 'Please provide your iRODS username? '

"
{
    "irods_host": "uva-yoda.irods.surfsara.nl",
    "irods_port": 1247,
    "irods_home": "/yoda/home",
    "irods_user_name": "$iRODSUsername",
    "irods_zone_name": "yoda",
    "irods_authentication_scheme": "pam",
    "irods_encryption_algorithm": "AES-256-CBC",
    "irods_encryption_key_size": 32,
    "irods_encryption_num_hash_rounds": 16,
    "irods_encryption_salt_size": 8,
    "irods_client_server_negotiation": "request_server_negotiation"
}
" | out-file irods_environment.json

# building docker container
Write-Host "Building container.."
docker image build -t ubuntu-1804-icommands . 

# start docker container
Write-Host "Starting container.."
docker container run --name iRODS-icommands --detach ubuntu-1804-icommands:latest tail -f /dev/null

# connecting docker container
Write-Host "Connecting to the container.."
docker exec -it iRODS-icommands bash

# stopping docker container
Write-Host "Stoping the container.."
docker container stop iRODS-icommands

# cleaning up 
Write-Host "Removing container.."
docker container rm --force iRODS-icommands
Write-Host "Removing image.."
docker image rm --force ubuntu-1804-icommands 
