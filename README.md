# Ashwin's dotfiles

![hyprland](./assets/hyprland.png)
<details>
  <summary>more screenshots</summary>

![emacs](./assets/emacs.png)
![rofi](./assets/rofi.png)
![rmpc](./assets/rmpc.png)
![terminal](./assets/terminal.png)
![qutebrowser](./assets/qutebrowser.png)
</details>

## Configurations

- [vim](https://github.com/vim/vim/) ([NeoVim](https://github.com/neovim/neovim/) & [LunarVim](https://github.com/LunarVim/LunarVim/))
  - Plugins are managed with [Lazy](https://github.com/folke/lazy.nvim.git")
- [emacs](https://www.gnu.org/software/emacs/)
- [doom emacs](https://github.com/doomemacs/doomemacs)
- [helix](https://github.com/helix-editor/helix/)
- [bash](https://www.gnu.org/software/bash/)
- [fish](https://fishshell.com/)
- [zsh](https://www.zsh.org/)
- [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k/)
- [tmux](https://github.com/tmux/tmux/)
- [hypr](https://github.com/hyprwm/)
  - [hyprland](https://github.com/hyprwm/hyprland/)
  - [hyprlock](https://github.com/hyprwm/hyprlock/)
  - [hypridle](https://github.com/hyprwm/hypridle/)
  - [hyprpaper](https://github.com/hyprwm/hyprpaper/)
  - [hyprshade](https://github.com/loqusion/hyprshade/)
- [swaync](https://github.com/ErikReider/SwayNotificationCenter/)
- [rofi](https://github.com/davatorium/rofi)
- [ghostty](https://ghostty.org/)
- [waybar](https://github.com/Alexays/Waybar/)
- [kanata](https://github.com/jtroo/kanata/)
- [kmonad](https://github.com/kmonad/kmonad)
- [tacky-borders](https://github.com/lukeyou05/tacky-borders/)
- [kitty](https://github.com/kovidgoyal/kitty/)
- [alacritty](https://github.com/alacritty/alacritty/)
- [wezterm](https://github.com/wezterm/wezterm/)
- [hyper](https://github.com/vercel/hyper/)
- [zen-browser](https://zen-browser.app/)

### Vim (NeoVim & LunarVim) config

Requires Neovim (>= 0.9)

- [LunarVim](https://www.lunarvim.org/) - Fast IDE layer for Neovim with awesome plugins already installed.

### Fish config

- [fish shell](https://fishshell.com/)
- [Oh My Posh](https://ohmyposh.dev/) - Prompt theme engine
- [fisher](https://github.com/jorgebucaran/fisher/) - a plugin manager for Fish
- [tide](https://github.com/IlanCosman/tide/) - the ultimate fish prompt
- [nvm](https://github.com/jorgebucaran/nvm.fish/) - node package manager for fish
- [zoxide](https://github.com/ajeetdsouza/zoxide) - directory jumper

### Zsh config

- [zsh shell](https://ohmyz.sh/)
- [nerd font](https://www.nerdfonts.com/) - Powerline-patched fonts.
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Directory jumping
- [exa](https://the.exa.website/) - `ls` replacement
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like fast/unobtrusive autosuggestions for zsh.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Fish shell-like syntax highlighting for zsh.

## Steps to install

### Linux

1. Clone this repository to your home directory.

```bash
# Using gh
gh repo clone shadowash8/dotfiles ~/.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/shadowash8/dotfiles.git ~/.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```bash
stow .
```

### Windows

1. Clone this repository to your home directory.

```pwsh
# Using gh
gh repo clone shadowash8/dotfiles $HOME\.dotfiles

# ...or use HTTPS and switch remotes later.
git clone https://github.com/shadowash8/dotfiles.git $HOME\.dotfiles
```

2. Create symlinks in the Home directory to the real files in the repo.

```pwsh
cd $HOME/.dotfiles
./dotfiles.ps1
```
