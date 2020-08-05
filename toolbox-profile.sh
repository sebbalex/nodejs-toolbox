dpt_bogus_path=${1:-"$HOME/dpt-bogus"}

function docker_run_stoolbox {
  docker run --rm -it \
    -p 3000:3000 \
    -v $PWD:/devops \
    sebbalex-toolbox:latest $@
}

node() {
  docker_run_stoolbox node $@
}

npm() {
  docker_run_stoolbox npm $@
}

npx() {
  docker_run_stoolbox npx $@
}

nvm() {
  docker_run_stoolbox nvm $@
}

nodenv() {
  docker_run_stoolbox nodenv $@
}

deno() {
  docker_run_stoolbox deno $@
}

yarn() {
  docker_run_stoolbox yarn $@
}
