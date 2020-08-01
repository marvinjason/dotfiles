## Prerequisites

Make sure you have vim and tmux installed. If you are going to enable cursorline, make sure you have vim 8.1+ installed. There is an issue with scolling performance when cursorline is enabled for lower versions.

To build vim from source in Ubuntu:

```sh
# You need a few stuff to build from source

sudo apt-get install ncurses
sudo apt-get install automake
sudo apt-get install libevent-dev

# Needed to enable xterm_clipboard support in vim
# Might need a few other stuff here
sudo apt-get install xorg-dev
```

```sh
git clone https://github.com/vim/vim.git
cd vim/src
make
sudo make install # Prefer using `checkinstall` if possible
```

You also need to install the latest tmux (or any version above `2.9`):

```sh
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
sudo make install # Prefer using `checkinstall` if possible
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
