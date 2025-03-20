function enterc() {
    docker exec -it $1 /bin/bash
}
export enterc

function findir() {
    SUFFIX=$1
    if [ -z "${SUFFIX}" ]; then
        SUFFIX="ttir"
    fi
    find ~/.triton/cache/ -type f -name "*.${SUFFIX}"
}
export findir

