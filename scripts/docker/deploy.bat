set ENV=development

set REGION=eu-west-1
set AWS_ACCOUNT_ID=724443507988
set PROFILE=default

set AWS_DOCKER_REGISTRY_URL=%AWS_ACCOUNT_ID%.dkr.ecr.%REGION%.amazonaws.com

docker logout %AWS_DOCKER_REGISTRY_URL%
rem Login in AWS container registry with your AWS credentials
aws ecr get-login-password --profile %PROFILE% --region %REGION% | docker login --username AWS --password-stdin %AWS_DOCKER_REGISTRY_URL%

rem Deploy app
eb deploy %ENV%
