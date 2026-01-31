# Configuration files

## How to bootstrap the config with Home-manager & chezmoi

- Download `private_dot_config/home-manager/home.nix` from this repo and place it in `~/.config/home-manager/`
- Install nix: `curl -fsSL https://install.determinate.systems/nix | sh -s -- install`
- [Install home-manager:](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)
- `export NIXPKGS_ALLOW_UNFREE = "1"`
- Run `home-manager switch --impure`, now `chezmoi` and `gh` are installed
- Run: 

```bash
gh auth login # Login to gihtub account
chezmoi init https://github.com/thibthibaut/dotfiles.git
chezmoi cd
chezmoi execute-template < ./run_once_before_decrypt-private-key.sh.tmpl > ~/decrypt-key.sh
chmod +x ~/decrypt-key.sh
~/decrypt-key.sh
```

- Edit ~/.config/chezmoi/chezmoi.toml with 

```
encryption = "age"
[age]
    identity = "~/.config/chezmoi/key.txt"
    recipient = "<Fill in the public key>"
```

- Run `chezmoi apply -v`
