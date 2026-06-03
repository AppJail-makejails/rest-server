# rest-server

Rest Server is a high performance HTTP server that implements restic's REST backend API. It provides secure and efficient way to backup data remotely, using restic backup client via the rest: URL.

<img src="https://avatars.githubusercontent.com/u/10073512" width="60%" height="auto">

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
    -o fstab="$PWD/volumes/rest-server /var/db/restserver" \
    -o container="args:--pull"
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
* `restserver_from` (default: `ghcr.io/appjail-makejails/rest-server`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `restserver_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Volumes

| Name            | Owner     | Group     | Perm | Type | Mountpoint         |
| --------------- | --------- | --------- | ---- | ---- | ------------------ |
| rest-server-db  | `${puid}` | `${pgid}` |  -   |  -   | /var/db/restserver |

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.0
      containerfile: Containerfile.pkg
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.0"
```

## Notes

1. This Makejail includes [gh+AppJail-makejails/user-mapping](https://github.com/AppJail-makejails/user-mapping).
