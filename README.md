# rest-server

Rest Server is a high performance HTTP server that implements restic's REST backend API. It provides secure and efficient way to backup data remotely, using restic backup client via the rest: URL.

<img src="https://avatars.githubusercontent.com/u/10073512" width="80%" height="auto">

github.com/restic/rest-server

## How to use this Makejail

### Basic usage

```sh
mkdir -p volumes/rest-server
appjail makejail \
    -j rest-server \
    -f gh+AppJail-makejails/rest-server \
    -o virtualnet=":<random> default" \
    -o nat \
    -o fstab="$PWD/volumes/rest-server /var/db/restserver"
```

### Adding users

```sh
# Password from prompt.
appjail cmd jexec rest-server create_user myuser
# Read password from command line.
appjail cmd jexec rest-server create_user myuser passwd321@
```

### Arguments

* `restserver_noauth` (default: `0`): Disable authentication.
* `restserver_options` (optional): Options to be passed to rest-server.
* `restserver_tag` (default: `13.2`): See [#tags](#tags).

## Tags

| Tag    | Arch     | Version        | Type   |
| ------ | -------- | -------------- | ------ |
| `13.2` | `amd64`  | `13.2-RELEASE` | `thin` |
| `14.0` | `amd64`  | `14.0-RELEASE` | `thin` |
