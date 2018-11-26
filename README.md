## Prerequisites

Make sure you have vim 8.1+ installed. There is an issue with scolling performance when cursorline is enabled for lower versions.

To build from source:

```sh
# You need a few stuff to build from source

sudo apt-get install ncurses
sudo apt-get install automake
sudo apt-get install libevent-dev

# Needed to enable xterm_clipboard feature in vim
# Might need a few other stuff here
sudo apt-get install xorg-dev
```

```sh
git clone https://github.com/vim/vim.git
cd vim/src
make
sudo make install
```

You also need to install the latest tmux:

```sh
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install
```

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

Note: This will remove configurations set up by dotfiles including installed binaries.
