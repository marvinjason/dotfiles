## Prerequisites

Make sure you have vim and tmux installed.

To build vim from source in Ubuntu 20.04:

```sh
git clone https://github.com/vim/vim.git
sudo apt build-dep vim
sudo apt install ncurses-dev
./configure --enable-gui=auto
make
sudo make install # or sudo checkinstall
```

Alternatively, you can simply install vim with clipboard support through the package manager:

```sh
# vim-gtk3 doesn't come with ruby support
# If you need that, install vim-athena instead
sudo apt install vim-gtk3

# Make sure vim-gtk3 is being used whenever you run vim
sudo update-alternatives --config vim
```

You also need to install the latest tmux (or any version above `2.9`).
You can do it either through the package manager, or by building from source:

```sh
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install # or sudo checkinstall
```

**Note**: If you're planning on using tmuxinator, you might want to check the list of compatible tmux versions first.

## Installation

To get set up with dotfiles:

```sh
git clone git@github.com:marvinjason/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

## Uninstallation

To remove the configs set up by dotfiles:

```sh
cd ~/.dotfiles
./uninstall
```

**Note**: This will remove configurations set up by dotfiles including installed binaries.
