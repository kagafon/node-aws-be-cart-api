set REGION=eu-west-1
set AWS_ACCOUNT_ID=944469896764

set DOCKER_APP_REPOSITORY=kagafon-cart-api
set AWS_DOCKER_REGISTRY_URL=%AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com
set DOCKER_LATEST_TAG=latest
set DOCKER_TIME_TAG=%date%-%time:~0,2%%time:~3,2%%time:~6,2%

rem Logout from Docker
docker logout %AWS_DOCKER_REGISTRY_URL%

rem Login in AWS container registry with your AWS credentials
aws ecr get-login-password --region %REGION% | docker login --username AWS --password-stdin %AWS_DOCKER_REGISTRY_URL%
rem Build Docker image
docker build -f "%~dp0/../../Dockerfiles/Dockerfile" -t %DOCKER_APP_REPOSITORY%:%DOCKER_TIME_TAG% -t %DOCKER_APP_REPOSITORY%:%DOCKER_LATEST_TAG% "%~dp0/../../"

rem Tag Docker image
docker tag %DOCKER_APP_REPOSITORY%:%DOCKER_LATEST_TAG% %AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com/%DOCKER_APP_REPOSITORY%:%DOCKER_LATEST_TAG%
docker tag %DOCKER_APP_REPOSITORY%:%DOCKER_TIME_TAG% %AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com/%DOCKER_APP_REPOSITORY%:%DOCKER_TIME_TAG%

rem Push/Publish Docker image
docker push %AWS_DOCKER_REGISTRY_URL%/%DOCKER_APP_REPOSITORY%
