# Quine's additions to nixpkgs: only what nixpkgs lacks. Each is written so
# it could go upstream, and goes away when upstream has it.
final: prev: {
  # samizdatco/nginx-http-auth-digest: HTTP Digest Authentication (RFC 2617)
  # for nginx, as `nginxModules.auth-digest` (services.nginx.additionalModules).
  nginxModules =
    prev.nginxModules
    // {
      auth-digest = {
        name = "auth-digest";
        src = prev.fetchFromGitHub {
          name = "auth-digest";
          owner = "samizdatco";
          repo = "nginx-http-auth-digest";
          rev = "77152ef18908996659f9f4338b85ce31b0731352";
          hash = "sha256-Tyk1GGBxGE2oiG5wOV90SrM9LkD4SDMID8szjXSnZG8=";
        };
        meta = {
          description = "HTTP Digest Authentication (RFC 2617) for nginx";
          homepage = "https://github.com/samizdatco/nginx-http-auth-digest";
          license = with prev.lib.licenses; [bsd2];
          maintainers = [];
        };
      };
    };
}
