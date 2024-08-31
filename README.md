This is my personal nvim settings! Feel free to copy them!

Run the following commands:

On Ubuntu:

```sudo apt-get install node```

On MacOS:

```brew install node  # npm is a dependency for some NvChad Mason packages```

If you need to install brew, visit https://brew.sh , and follow all instructions when installing to setup.


## Rest of Setup:

```mkdir ~/.config/nvim```

```git clone  --depth 1 https://github.com/stevehenny/my_nvim_settings.git ~/.config/nvim```

```nvim```

Neovim will now be installing a bunch of dependencies. After that is done, run the following in Neovim:

```:MasonInstallAll```

```:TSInstall cpp```

```:TSInstall python```

You should now have your own neovim configuration that supports python, c/c++! Happy neovimming!






