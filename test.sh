#!/bin/sh

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.

# Initialize our own variables:
shares=""
port=8888

while getopts "h?s:p:" opt; do
    case "$opt" in
    h|\?)
        show_help
        exit 0
        ;;
    s)  shares="$shares -v $OPTARG:$OPTARG"
        ;;
    p)  port=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "${1:-}" = "--" ] && shift

docker run -d \
	--name rmi-notebook \
	--rm \
	--user "$(id -u $USER):$(id -g $USER)" \
    $shares \
	-p $port:8888 \
	mrigroupopbg/mri-notebook

# echo "shares='$shares', port='$port'"
#	-v /data/RMN/MASTROGIOVANNI:/data/RMN/MASTROGIOVANNI \
#	-v $(pwd)/../notebooks:/home/jovyan \
#	-v /usr/local/freesurfer:/usr/local/freesurfer \
#	-v /usr/local/fsl:/usr/local/fsl \
