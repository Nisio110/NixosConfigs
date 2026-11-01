# My big boy NixOS config

hiiiii :3

- [ ] Should move as much of my config to hm as possible

## Personal task tracker (Baserow)

The `home-server/baserow.nix` module configures Baserow at
`https://todo.tetocorp.ie`, with dedicated PostgreSQL 15 and bundled Redis.
Both container images are pinned to Linux amd64 digests. Persistent database,
uploads, signing keys and generated credentials live under `/var/lib/baserow`.
There are **no automatic backups** and **no outgoing email**, by design.

### Deploy and sign in

This configuration must be deployed on the home server, not merely the machine
used to edit the repository:

```sh
sudo nixos-rebuild switch --flake .#hdesktop
sudo systemctl status docker-baserow-db docker-baserow baserow-bootstrap
sudo systemctl restart tetocorp-ssl
sudo cat /var/lib/baserow/secrets/admin-password
```

The certificate restart issues a leaf certificate containing the new hostname.
Clients must trust the existing TetoCorp CA and use the existing internal DNS
(which already maps all `tetocorp.ie` subdomains to `192.168.0.19`).
NetBird clients also need the existing route to that LAN address and internal DNS.

Sign in as `laneoisin64@gmail.com` using the generated password, then change it
in Baserow. The password file contains the **initial** password only; subsequent
starts do not reset the account. Keep the secrets directory private and never
commit its contents. Its database password must not be regenerated independently
of PostgreSQL's stored role password.

First startup waits for Baserow's health check, provisions the administrator and
personal tracker, and disables registration. nginx returns 503 until provisioning
succeeds. To diagnose or retry a failed bootstrap:

```sh
sudo journalctl -u docker-baserow -u baserow-bootstrap -n 100
sudo systemctl restart baserow-bootstrap
```

The tracker uses only free features: tasks with title, status, priority, due date,
project, notes and attachments, plus filtered grid views. No paid Kanban view or
license is required. A Tasks entry is included in the home dashboard.

### Access and maintenance

- nginx permits loopback, the home LAN (`192.168.0.0/24`), and the current NetBird
  network (`100.90.0.0/16`), denying other source addresses. This assumes the
  existing direct nginx ingress, not an upstream proxy that hides client IPs.
- Baserow's host port is loopback-only (`127.0.0.1:8787`); PostgreSQL has no
  published port. Do not expose the loopback backend with another proxy or tunnel.
- The shared Baserow data parent is `0711 root:root` so its different container
  users can traverse it. The secrets directory remains `0700 root:root`.
- PostgreSQL owns its data directory (UID/GID `999:999` in the current Debian
  image). The tmpfiles rule deliberately leaves ownership unspecified so rebuilds
  cannot reset it to root while PostgreSQL is running. If an older rule already
  did so, restore only the parent with
  `sudo chown 999:999 /var/lib/baserow/postgres`; do not recursively change modes.
- Attachments are limited to 100 MiB. Free-edition file URLs are not a substitute
  for per-file authorization: treat anyone with network access and a file URL as
  able to download it.
- Without SMTP, password-reset emails are not delivered. For local recovery:
  `sudo docker exec -it baserow /baserow.sh backend-cmd manage changepassword laneoisin64@gmail.com`.
- Before upgrading image pins, take a consistent PostgreSQL dump and preserve
  `/var/lib/baserow/data` and `/var/lib/baserow/secrets`. A live copy of PostgreSQL's
  data directory is not a consistent backup. Never bump the PostgreSQL major
  version without a database migration.
- If restoring or replacing the database, remove `/var/lib/baserow/ready` before
  starting it and rerun bootstrap; otherwise the old readiness marker could expose
  an unprovisioned instance.

### Configuration validation

The five Baserow systemd units build successfully. The secret-generation script
was exercised in temporary storage, including a second run proving that existing
credentials are preserved. The new nginx access/proxy directives pass `nginx -t`,
and the bootstrap script compiles.

No containers were started and no system switch was performed. First-run database
provisioning, login, uploads and browser behavior still require deployment-time
verification. Full-system derivation evaluation passes.

Bun uses the version pinned by nixpkgs, matching the `olaptop` package setup.
The obsolete mutable `bun-bin` download input has been removed; both the development
package list and the OMP launcher use `pkgs.bun`. Bun 1.4.2 was smoke-tested by
executing JavaScript through `nix shell`.

Deployment references: [Baserow Docker installation](https://baserow.io/docs/installation/install-with-docker)
and [configuration](https://baserow.io/docs/installation/configuration).
