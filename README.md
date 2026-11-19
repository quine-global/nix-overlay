# nix-overlay

Quine's additions to nixpkgs, as one overlay: only what nixpkgs lacks, each
written so it could go upstream, and removed when upstream has it.

| Adds | What |
|---|---|
| `nginxModules.auth-digest` | [samizdatco/nginx-http-auth-digest](https://github.com/samizdatco/nginx-http-auth-digest): HTTP Digest Authentication (RFC 2617) for nginx, for `services.nginx.additionalModules` |

## Use

```nix
inputs.quine-overlay.url = "github:quine-global/nix-overlay";
# …
nixpkgs.overlays = [ inputs.quine-overlay.overlays.default ];
```

It has no inputs of its own: it goes on top of whichever nixpkgs you use.
petersweb-infra (`nixos/flake.nix`) uses it for every host.

## Adding one

Add an entry to `overlay.nix` the way nixpkgs would have it (the same
attribute path, `meta` included), and a row above. When nixpkgs gets it,
delete the entry.

The forge (forge.in.quineglobal.com/quine-global/nix-overlay) is the source;
GitHub is its push mirror.
