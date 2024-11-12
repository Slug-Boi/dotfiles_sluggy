gc:
	nix-env --delete-generations old
	nix-store --gc

repl:
	nix --extra-experimental-features "nix-command flakes repl-flake" --show-trace repl

show:
	nix --extra-experimental-features "nix-command flakes" flake show

fmt:
	nix --extra-experimental-features "nix-command flakes" fmt

update:
	nix flake update

rebuild:
	nix run --extra-experimental-features 'nix-command flakes' .#build-switch

nixprofiles != ls -dv /nix/var/nix/profiles/system-*-link/|tail -2
homeprofiles != ls -dv ~/.local/state/nix/profiles/home-manager-*-link/|tail -2
show-diff:
	# ======== System diff ======== ";
	nix store diff-closures $(nixprofiles);

	# ======== home-manager diff ======== ";
	nix store diff-closures $(homeprofiles)
