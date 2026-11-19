# nix-overlay

Quine's additions to nixpkgs, as one overlay: only what nixpkgs lacks, each
written so it could go upstream, and removed when upstream has it.

| Adds | What |
|---|---|
| `kubernetes-git-sync` | [kubernetes/git-sync](https://github.com/kubernetes/git-sync) (keeps a repo checked out, runs a hook on new commits), with our `--exechook-path` (only when given paths change). Named so because nixpkgs' `git-sync` is a different tool. Its program is still `git-sync` |
| `mcli` | [pgsty/mc](https://github.com/pgsty/mc), the maintained fork of MinIO's `mc` (nixpkgs' `minio-client` stopped at 2025-08-13): its static release binary, Linux x86_64 and aarch64 |
| `nginxModules.auth-digest` | [samizdatco/nginx-http-auth-digest](https://github.com/samizdatco/nginx-http-auth-digest): HTTP Digest Authentication (RFC 2617) for nginx, for `services.nginx.additionalModules` |

## Use

```nix
inputs.quine-overlay.url = "github:quine-global/nix-overlay";
# …
nixpkgs.overlays = [ inputs.quine-overlay.overlays.default ];
```

It has no inputs of its own: it goes on top of whichever nixpkgs you use.

## Adding one

Add an entry to `overlay.nix` the way nixpkgs would have it (the same
attribute path, `meta` included), and a row above. When nixpkgs gets it,
delete the entry.
