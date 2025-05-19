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

function pid_in_docker() {
    PID=$1
    docker ps --no-trunc --format '{{.ID}} {{.Names}}' | grep $(cat /proc/$PID/cgroup | grep 'docker' | sed -E 's|.*docker-([a-f0-9]+)\.scope|\1|' | head -n1) | awk '{print $2}'
}
export pid_in_docker

function create_monitor_panel() {
    tmux split-window -h 'watch -n .1 amd-smi monitor -putmvq'
    # tmux split-window -v 'watch -n .1 amd-smi process --csv'
    tmux split-window -v 'watch -n .1 rocm-smi'
}
export create_monitor_panel

