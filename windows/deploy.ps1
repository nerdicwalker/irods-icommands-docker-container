# Input iRODS username
$iRODSUsername = Read-Host -Prompt 'Please provide your iRODS username? '

# building docker container
Write-Host "Building container.."
docker image build -t ubuntu-1804-icommands . 
rm -rf irods_environment.json

# start docker container
Write-Host "Starting container.."
docker container run --name iRODS-icommands --detach ubuntu-1804-icommands:latest tail -f /dev/null

# connecting docker container
Write-Host "Connecting to the container.."
docker run -it ubuntu-1804-icommands:latest bash

# stopping docker container
Write-Host "Stoping the container.."
docker container stop iRODS-icommands

# cleaning up 
Write-Host "Removing container.."
docker container rm --force iRODS-icommands
Write-Host "Removing image.."
docker image rm --force ubuntu-1804-icommands