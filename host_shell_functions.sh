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

unzipd() {
    local zipfile="$1"

    if [[ -z "$zipfile" ]]; then
        echo "Usage: unzipd <file.zip>"
        return 1
    fi

    if [[ ! -f "$zipfile" ]]; then
        echo "ERROR: $zipfile doesn't exist"
        return 1
    fi

    local filename="${zipfile##*/}"
    local dirname="${filename%.zip}"

    mkdir -p "$dirname"
    unzip -d "$dirname" "$zipfile"
}
export unzipd

pgit() {
    local key_file="$HOME/.ssh/id_ed25519_amdeng"
    if [[ ! -f "$key_file" ]]; then
        echo "ERROR: SSH key file '$key_file' does not exist"
        return 1
    fi
    GIT_SSH_COMMAND="ssh -i $key_file -o IdentitiesOnly=yes" git "$@"
}
export pgit

create_ed_key() {
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q && cat ~/.ssh/id_ed25519.pub
}
export create_ed_key

create_auth_key_dir() {
    mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys
}
export create_auth_key_dir

create_user_with_sudo() {
    username=$1
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists. Skipping creation."
        return 0
    fi
        sudo useradd -m -s /bin/bash "$username" && sudo usermod -aG docker "$username" && echo "$username ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/90-"$username" >/dev/null && sudo chmod 440 /etc/sudoers.d/90-"$username"
}
export create_user_with_sudo

init_git() {
    git config --global user.name "Kyle Wang"
    git config --global user.email "ec1wng@gmail.com"
    git config --global core.editor "vim"
}
export init_git
