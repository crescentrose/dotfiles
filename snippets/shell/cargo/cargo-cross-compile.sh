# cargo: cross compile for Linux via Docker
docker run --rm --user "$(id -u)":"$(id -g)" -v "$PWD":/usr/src/myapp -w /usr/src/myapp rust:1.44 "cargo build --release"
