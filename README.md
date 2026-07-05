# rest-server

Rest Server is a high performance HTTP server that implements restic's REST backend API. It provides secure and efficient way to backup data remotely, using restic backup client via the rest: URL.

restic.net

<img src="https://avatars.githubusercontent.com/u/10073512" width="30%" height="auto" alt="rest-server logo">

## How to use this Makejail

### Basic usage

```console
$ mkdir -p /var/appjail-volumes/rest-server/data
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    -o container="args:--pull" \
    -o fstab="/var/appjail-volumes/rest-server/data /data" \
    ghcr.io/appjail-makejails/rest-server rest-server
```

### Adding users

**Password from prompt**:

```console
$ appjail oci exec rest-server create_user myuser passwd321@
```

**Read password from command line**:

```console
$ appjail oci exec rest-server create_user myuser
```

### Deleting users

```console
$ appjail oci exec rest-server delete_user myuser
```

### Arguments (stage: build)

* `restserver_from` (default: `ghcr.io/appjail-makejails/rest-server`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `restserver_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `DATA_DIRECTORY` (default: `/data`): Data volume location.
* `DISABLE_AUTHENTICATION` (optional): By default, the image uses authentication. To turn it off, set this environment variable to any value.
* `OPTIONS` (optional): You can set this environment variable to any extra flags you'd like to pass to rest-server.
* `PASSWORD_FILE` (default: `/data/.htpasswd`): By default, the image loads the `.htpasswd` file from the persistent data volume (i.e. from `/data/.htpasswd`). To change the location of this file, set the environment variable `PASSWORD_FILE` to the path of the `.htpasswd` file. Please note that this path must be accessible from inside the container and should be persisted. This is normally done by `nullfs(4)`-mounting a path into the container or with another appjail volume.
* `PGID` (optional): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

### Volumes

| Name | Owner | Group | Perm | Type | Mountpoint |
| --- | --- | --- | --- | --- | --- |
| appjail-263aca83a3-data | `${PUID}` | `${PGID}` | - | - | /data |

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
