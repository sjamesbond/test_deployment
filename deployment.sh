#!/bin/bash

usage() { echo "Usage: $0 [-t <local|docker|aws>] [-p <port>]" 1>&2; exit 1; }

while getopts ":t:p:" o; do
    case "${o}" in
        t)
            type=${OPTARG}
            ((type == "local" || type == "docker" || type == "aws")) || usage
            ;;
        p)
            port=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [[ "$type" == "local" ]]; then 
    echo "Deploying locally." && git clone https://github.com/sjamesbond/hello_flask.git &&  gunicorn -b 0.0.0.0:$port --chdir ./hello_flask wsgi:app
elif [[ "$type" == "docker" ]]; then
    echo "Deploying to Docker locally." && sudo docker run -it -d -p $port:8000 sjamesbond/twingate:0.0.1.0
elif [[ "$type" == "aws" ]]; then
    echo "Deploying to AWS" && terraform apply
else
     usage
fi
