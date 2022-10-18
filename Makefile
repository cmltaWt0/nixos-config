.PHONY: build flake

build:
	nix build .#darwinConfigurations.cmltawt0.system

darwin:
	./result/sw/bin/darwin-rebuild switch --flake .
