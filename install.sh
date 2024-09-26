#!/bin/bash

git clone https://github.com/vstkl/conf ~/.config/ -b arch &&
  ~/.config/packaging.sh
git clone https://github.com/lazyvim/starter ~/.config/nvim && rm -rf ~/.config/nvim/.git
