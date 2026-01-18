# rest-server

Rest Server is a high performance HTTP server that implements restic's REST backend API. It provides secure and efficient way to backup data remotely, using restic backup client via the rest: URL.

<img src="https://avatars.githubusercontent.com/u/10073512" width="80%" height="auto">

restic.net

## How to use this Makejail

### Basic usage

```sh
mkdir -p volumes/rest-server
chown -f 239:239 volumes/rest-server
appjail makejail \
    -j rest-server \
    -f gh+AppJail-makejails/rest-server \
    -o virtualnet=":<random> default" \
    -o nat \
    -o expose=8000 \
    -o fstab="$PWD/volumes/rest-server /var/db/restserver"
```

### Adding users

```sh
# Password from prompt.
appjail cmd jexec rest-server create_user myuser
# Read password from command line.
appjail cmd jexec rest-server create_user myuser passwd321@
```

### Deleting users

```sh
appjail cmd jexec rest-server delete_user myuser
```

### Arguments

* `restserver_noauth` (default: `0`): Disable authentication.
* `restserver_options` (optional): Options to be passed to rest-server.
* `restserver_ajspec` (default: `gh+AppJail-makejails/rest-server`): Entry point where the `appjail-ajspec(5)` file is located.
* `restserver_tag` (default: `14.3`): See [#tags](#tags).

### Volumes

| Name            | Owner | Group | Perm | Type | Mountpoint         |
| --------------- | ----- | ----- | ---- | ---- | ------------------ |
| rest-server-db  | 239   | 239   |  -   |  -   | /var/db/restserver |

## Tags

| Tag    | Arch     | Version        | Type   |
| ------ | -------- | -------------- | ------ |
| `14.3` | `amd64`  | `14.3-RELEASE` | `thin` |
| `15` | `amd64`  | `15` | `thin` |
