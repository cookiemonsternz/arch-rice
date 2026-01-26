#!/bin/bash

#echo "Cookiemonsternz's dotfiles! Install loading"

if [ "$OSTYPE" != "linux-gnu" ]; then
    echo -e "Please run on Arch Linux\n"
    exit
fi

ISARCH=/etc/arch-release
if [ ! -f "$ISARCH" ]; then
  echo -e "Pleasse run on Arch Linux\n"
  exit
fi

HASPARU=/sbin/paru
if [ -f "$HASPARU" ]; then
  echo -e "paru found. continuing...\n"
else
  echo -e "paru not found. please install paru first.\n"
fi

read -n1 -rep "install packages? (y/n)" INST
if [[ $INST == "Y" || $INST == "y" ]]; then
    # Paru install packages
    paru -S --noconfirm noctalia-shell alacritty sddm fuzzel fastfetch zsh fish fortune cowsay ponysay dopamine-official

    echo "packages installed"
fi

read -n1 -rep "would you like to copy config files (WARNING: WILL OVERWRITE EXISTING FILES)? (y/n)" CPC
if [[ $CPC == "Y" || $CPC == "y" ]]; then
    ln -srf ./alacritty/alacritty.toml ~/.config/alacritty/
    ln -srf ./fastfetch/config.jsonc ~/.config/fastfetch/
    ln -srf ./fish/config.fish ~/.config/fish/
    ln -srf ./fortune/cats /usr/share/fortune/
    ln -srf ./fortune/cats.dat /usr/share/fortune/
    ln -srf ./fuzzel/fuzzel.ini ~/.config/fuzzel
    ln -srf ./noctalia/plugins/media-controls ~/.config/noctalia/plugins
    ln -srf ./noctalia/settings.json ~/.config/noctalia
    ln -srf ./sddm.conf.d/override.conf /etc/sddm.conf.d/
    ln -srf ./zsh/.zshrc ~/
    ln -srf ./hyfetch/hyfetch.json ~/.config/

    # Some programs can't read symlinks for some reason :( - copy raw files
    cp -r ./sddm/themes/rosepinemoon /usr/share/sddm/themes/
    cp -r ./dopamine/Themes/RosePineMoon.theme ~/.config/dopamine/Themes

    echo "Finished writing conf files"
fi

echo "install complete! ty for trying my dotfiles :3\n"
echo "if it breaks thats probs my fault this install script is completely untested :)\n"

echo "Last thing - I don't write niri conf by default bc i don't think thats wanted - but feel free to copy the bits you'd like (keybinds, window rules, etc) into your config.kdl"