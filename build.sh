if [ ! -d "/nix" ]; then
    echo "Nix package manager not found, installing..."
    curl -L https://nixos.org/nix/install | sh
fi

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on MacOS, building system..."

    # homebrew needs to be explicitly installed as per https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
    if [ ! -d "/opt/homebrew" ]; then
        echo "Homebrew could not be found, installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # build the actual system
    if [ -d "result" ]; then
        echo "Directory \"result\" exists, rebuilding system..."
        ./result/sw/bin/darwin-rebuild test --flake .#mb $@
    else
        echo "result directory does not exist, initializing first build..."
        nix build .#darwinConfigurations.mb.system --extra-experimental-features nix-command --extra-experimental-features flakes $@
    fi
else
    echo "Running on NixOS, building system..."
    sudo nixos-rebuild test --flake .#tp $@
fi
