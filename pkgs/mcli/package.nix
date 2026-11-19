# mcli: Silo's client (github.com/pgsty/mc), the maintained fork of MinIO's
# `mc`, which MinIO abandoned (nixpkgs' minio-client stopped at 2025-08-13). Same
# commands, `mcli admin` included. Not in nixpkgs: the release's static
# binary. Bumping: the new tag, and each tarball's line from its
# mcli_<v>_checksums.txt.
{
  lib,
  stdenvNoCC,
  fetchurl,
}: let
  tag = "RELEASE.2026-11-09T00-00-00Z";
  v = "20261109000000.0.0";
  arch =
    {
      x86_64-linux = {
        name = "amd64";
        sha256 = "79e6cf4ad00a9e5eb2e7ceccc6e6496e4af4ec096e59695515ea8f223c287e4a";
      };
      aarch64-linux = {
        name = "arm64";
        sha256 = "5473c4b39a31dd66478f5c44686a09f3e9e37861a30f1faf18564fbe66118387";
      };
    }
    .${stdenvNoCC.hostPlatform.system};
in
  stdenvNoCC.mkDerivation {
    pname = "mcli";
    version = v;
    src = fetchurl {
      url = "https://github.com/pgsty/mc/releases/download/${tag}/mcli_${v}_linux_${arch.name}.tar.gz";
      inherit (arch) sha256;
    };
    sourceRoot = ".";
    installPhase = "install -Dm755 mcli $out/bin/mcli";
    meta = {
      description = "Silo's S3 client and admin tool, a fork of MinIO's mc";
      homepage = "https://github.com/pgsty/mc";
      license = lib.licenses.agpl3Plus;
      platforms = ["x86_64-linux" "aarch64-linux"];
      mainProgram = "mcli";
    };
  }
