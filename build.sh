if [ "$(uname)" == "Darwin" ]; then
    echo "Running on MacOS, building system..."
    if [ -d "result" ]; then
        echo "result directory exists, rebuilding system..."
        ./result/sw/bin/darwin-rebuild switch --flake .#mb $@
    else
        echo "result directory does not exist, initializing first build..."
        nix build .#darwinConfigurations.mb.system --extra-experimental-features nix-command --extra-experimental-features flakes $@
    fi
else
    echo "Running on NixOS, building system..."
    sudo nixos-rebuild switch --flake .#tp $@
fi
