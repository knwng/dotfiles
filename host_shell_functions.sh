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

alias list_docker='docker ps -a | grep kylewng'
alias trigger_ci='git commit -m "trigger CI" --allow-empty'
export PATH="${HOME}/.local/bin:${PATH}"

export SSH_ENV="$HOME/.ssh/agent-environment"
start_agent() {

    echo "Starting new ssh-agent..."
    (umask 066; ssh-agent -a "$HOME/.ssh/ssh-agent.sock" > "$SSH_ENV")
    source "$SSH_ENV"
    # Load *all* private keys that don't already live in the agent
    for key in ~/.ssh/id_*; do
        [[ -f "$key" && "$key" != *.pub ]] && ssh-add -l | grep -q "$(ssh-keygen -lf "$key" | awk '{print $2}')" || ssh-add "$key" 2>/dev/null
    done
    export SSH_AUTH_SOCK_DIR="$(dirname "$SSH_AUTH_SOCK")"
}

if [[ -f "$SSH_ENV" ]]; then
    rm -rf "$HOME/.ssh/ssh-agent.sock"
    source "$SSH_ENV" > /dev/null
    [[ "$SSH_AUTH_SOCK" != "$HOME/.ssh/ssh-agent.sock" || ! -S "$HOME/.ssh/ssh-agent.sock" ]] && start_agent
    # Agent dead?  Restart.
    kill -0 "$SSH_AGENT_PID" 2>/dev/null || start_agent
else
    start_agent
fi

# Always export the directory helper so VS Code can see it
export SSH_AUTH_SOCK_DIR="$(dirname "$SSH_AUTH_SOCK")"

