# NodeJS Toolbox

### build
```sh
$ docker build . -t nodejs-toolbox
```

### include in your environment
```sh
$ echo "source ${PWD}/toolbox-profile.sh" >> ~/.bashrc
```

### Ready to go, type your command
```sh
$ node -v
$ npm -v
$ deno --version
$ yarn -v
```