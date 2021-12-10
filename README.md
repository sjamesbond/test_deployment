# Usage
This deployment script can deploy our sample app in one of 4 ways:
  1. Run the app locally. This assumes gunicorn and flask have been installed locally and are available.
  2. Run a prebuilt docker image of the application from dockerhub locally. This assumes docker is installed and available locally.
  3. Build the docker container and run locally.This assumes docker is installed and available locally.
  4. Deploy an EC2 to AWS using terraform and run a prebuilt docker image of the app. This could easily be modified to build the container on the EC2 instead of using the prebuilt image.

The options for the script are:
  -d The deployment type, whether aws, local using gunicorn, docker-local or docker from github
  -n the name of the image if building locally
  -t the tag for the image
  -p the port number used if running the image locally. 
Examples of usage are
  ./deployment.sh -d docker-local -n test -t 0.1
  ./deployment.sh -t local -p 8002
  ./deployment.sh -t aws
  ./deployment.sh -d docker-local -n test -t 0.1
