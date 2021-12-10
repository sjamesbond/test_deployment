#!/bin/bash

usage() { echo "Usage: $0 [-d <local|docker|docker-local|aws>] [-p <port>] [-n <name>] [-t <tag>]" 1>&2; exit 1; }

while getopts ":d:n:t:p:" o; do
    case "${o}" in
        d)
            type=${OPTARG}
	    echo $type
            ((type == "local" || type == "docker" || type == "docker-local" || type == "aws")) || usage
            ;;
        p)
            port=${OPTARG}
            ;;
        n)
            name=${OPTARG} 
	    ;;
	t)
            tag=${OPTARG}
	    ;;	
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [[ "$type" == "local" ]]; then 
    echo "Deploying locally." && git clone https://github.com/sjamesbond/hello_flask.git &&  gunicorn -b 0.0.0.0:$port --chdir ./hello_flask wsgi:app
elif [[ "$type" == "docker-local" ]]; then
    echo "Building Image and Deploying to Docker locally." && git clone https://github.com/sjamesbond/hello_flask.git && sudo docker build -t $name:$tag hello_flask/ && sudo docker run -it -d -p $port:8000 $name:$tag
elif [[ "$type" == "docker" ]]; then
    echo "Deploying to Docker locally." && sudo docker run -it -d -p $port:8000 sjamesbond/twingate:0.0.1.0
elif [[ "$type" == "aws" ]]; then
    echo "Deploying to AWS" && terraform apply
else
     usage
fi
