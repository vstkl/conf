#!/bin/bash

# Set the theme name
THEME_NAME="darkviolet"

# Install base16-shell if not already installed
if [ ! -d ~/.config/base16-shell ]; then
  git clone https://github.com/chriskempson/base16-shell.git
  cd base16-shell
  make install
fi

# Generate theme files for all supported applications
base16-shell --generate --theme=$THEME_NAME

# Configure GTK applications
GTKRC_FILE=~/.gtkrc-2.0
if [ -f $GTKRC_FILE ]; then
  echo "include=~/.config/base16-shell/gtk-2.0/base16-$THEME_NAME.gtkrc" >>$GTKRC_FILE
else
  echo "gtk-theme-name=base16-$THEME_NAME" >>$GTKRC_FILE
fi

# Configure Qt applications
QT5CT_FILE=~/.config/qt5ct/qt5ct.conf
if [ -f $QT5CT_FILE ]; then
  sed -i "s/style=.*/style=base16-$THEME_NAME/" $QT5CT_FILE
else
  echo "style=base16-$THEME_NAME" >>$QT5CT_FILE
fi

# Configure GNOME desktop
GNOME_SHELL_FILE=~/.config/gnome-shell/extensions/user-theme@gnome-shell-extensions.gcampax.github.com/stylesheet.css
if [ -f $GNOME_SHELL_FILE ]; then
  echo "@import url(\"~/.config/base16-shell/gnome-shell/base16-$THEME_NAME.css\");" >>$GNOME_SHELL_FILE
fi

# Configure Neovim
NEOVIM_FILE=~/.config/nvim/init.vim
if [ -f $NEOVIM_FILE ]; then
  echo "colorscheme base16-$THEME_NAME" >>$NEOVIM_FILE
fi

# Configure ZSH
ZSHRC_FILE=~/.zshrc
if [ -f $ZSHRC_FILE ]; then
  echo "autoload -U colors && colors -b -c base16-$THEME_NAME" >>$ZSHRC_FILE
fi

# Configure Tmux
TMUX_FILE=~/.tmux.conf
if [ -f $TMUX_FILE ]; then
  echo "set -g theme base16-$THEME_NAME" >>$TMUX_FILE
fi

# Configure Ranger
RANGER_FILE=~/.config/ranger/rc.conf
if [ -f $RANGER_FILE ]; then
  echo "set theme base16-$THEME_NAME" >>$RANGER_FILE
fi

echo "Theme $THEME_NAME applied to all supported applications!"
