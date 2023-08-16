# Tiddly PWA

Docker image for  [TiddlyPWA](https://tiddly.packett.cool/)

## Usage

### Create a password hash & salt

```sh
docker run --rm -it zayon/tiddly-pwa:latest hash-admin-password
```

Then type an admin password, the command will output 2 environment variables: `ADMIN_PASSWORD_HASH` and `ADMIN_PASSWORD_SALT` that needs to be used when running the server

### Run the server

```sh
docker run --name tiddly-pwa -d \
    -e ADMIN_PASSWORD_HASH=<replace with value> \
    -e ADMIN_PASSWORD_SALT=<replace with value> \
    -v /path/to/db:/var/db/tiddly \
    zayon/tiddly-pwa
```

---

[Back to home](https://github.com/Zayon/dockerfiles)

