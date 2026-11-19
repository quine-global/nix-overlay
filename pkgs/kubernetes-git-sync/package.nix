# kubernetes-git-sync (kubernetes/git-sync): keeps a git repo checked out and runs a hook
# on each new commit. Not nixpkgs' `git-sync` (simonthum's script, another
# tool, hence the name), and its releases are container images only, so it's built here, for
# petersweb-infra's NixOS hosts and its Mac mini alike.
#
# With our fork's one change, --exechook-path (run the hook only when given
# paths change): quine-global/git-sync on the forge, exported as
# ./exechook-path.patch (`git diff v4.8.0 main`), since
# the forge is tailnet-only and private, which Nix's fetchers can't reach.
{
  lib,
  buildGoModule,
  fetchFromGitHub,
  makeWrapper,
  git,
  openssh,
}:
buildGoModule rec {
  pname = "kubernetes-git-sync";
  version = "4.8.0";

  src = fetchFromGitHub {
    owner = "kubernetes";
    repo = "git-sync";
    rev = "v${version}";
    hash = "sha256-SiT5qFAbDeYA3kfIXbcNs17T+/SA5zkPFjjkAqHpgTE=";
  };

  patches = [./exechook-path.patch];

  # The repo vendors its dependencies.
  vendorHash = null;

  subPackages = ["."];
  ldflags = ["-s" "-w" "-X k8s.io/git-sync/pkg/version.VERSION=v${version}"];

  # Its tests drive real git repos and a test SSH server.
  doCheck = false;

  nativeBuildInputs = [makeWrapper];
  # It runs git (and git runs ssh) rather than linking a git library.
  postInstall = ''
    wrapProgram $out/bin/git-sync --prefix PATH : ${lib.makeBinPath [git openssh]}
  '';

  meta = {
    description = "Keep a git repo checked out, and run a hook on each new commit";
    homepage = "https://github.com/kubernetes/git-sync";
    license = lib.licenses.asl20;
    mainProgram = "git-sync";
  };
}
