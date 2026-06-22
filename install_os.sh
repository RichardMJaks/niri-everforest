#!/bin/bash

# vim: fdm=marker fmr={{{,}}}

echo "Dotfiles can be created by either replacing files with the ones in this repository, or by creating symlinks."
echo "Hard replacement allows you to create your own settings, and keep your modifications."
echo "With symlinks all your changes will be linked to the ones in this repository, and any changes made will be overwritten after every pull from the repository."
printf "Create symlinks instead of replacement? [y/N]: "
read create_symlinks
create_symlinks=$(create_symlinks,,}

backupAndReplace() {
	local target_file="$1"
	local replacement_file="$2"
	# Validate args
	if [ -z "$target_file" ] || [ -z "replacement_file" ]; then
		echo "Usage: backupAndReplace target_file replacement_file"
		return 1
	fi
	
	echo "Replacing $target_file..."
	# Create backup if file exists
	if [ -e "$target_file" ]; then
		sudo mv "$target_file" "$target_file".bkp
	fi

	# Replace the file
	if [ create_symlinks -eq "y" ]; then
		sudo ln -sr "$replacement_file" "$target_file"
	else
		sudo cp "$replacement_file" "$target_file"
	fi
}
echo "Installing packages..."
read sync_packages < sync_packages.txt
read aur_packages < aur_packages.txt

# Install required packages
sudo pacman -S sync_packages
sudo paru -S aur_packages

echo "Enabling wheel group in /etc/sudoers..."
# Give sudo permissions to wheel group
sudo sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL' /etc/sudoers

echo "Creating user..."
#{{{ User creation
printf "Enter your username: "
read username

password_initial="1"
password_after="0"
while
	printf "Enter your password: "
	read -s password_initial

	printf "Repeat your password: "
	read -s password_after
	[[ "$password_initial" != "$password_after" ]]
do true; done

# Initialize the user with some basic groups
useradd -m -G games,video,storage,kvm,input,audio,wheel -P "$password_initial" "$username"
#}}}

homedir=$(eval echo ~"$username")

# NetworkManager Setup
echo "Enabling NetworkManager.service..."
sudo systemctl enable --now NetworkManager.service

# Polkit Setup
echo "Setting polkit rules..."
sudo cp polkit-1 /etc/
echo "Setting udisks2 rules..."
sudo cp udisks2 /etc/
echo "Enabling polkit.service..."
sudo systemctl enable --now polkit.service

#{{{ ZSH Configuration
echo "Setting zsh as default shell for the user..."
runuser -l $username -c 'chsh -s $(which zsh)' # Set zsh as default shell for user
# Install oh-my-zsh
echo "Installing oh-my-zsh..."
runuser -l "$username" -c 'sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
backupAndReplace "$homedir"/.zshrc zsh/zshrc

# SDDM Setup
echo "Enabling sddm.service..."
sudo systemctl enable sddm.service
echo "Setting sddm theme to 'Noctalia'..."
backupAndReplace /etc/sddm.conf sddm/sddm.conf
echo "Setting permissions 666 for SDDM Noctalia theme.conf"
chmod 666 /usr/share/sddm/themes/noctalia/theme.conf
echo "Adding color sync for SDDM Greeter..."
backupAndReplace noctalia_user/user-templates.toml ~/.config/noctalia/user-templates.toml
echo "Setting permissions 666 to noctalia background..."
sudo chmod 666 "/usr/share/sddm/themes/noctalia/Assets/background.png"

# Starship prompt
backupAndReplace "$homedir"/.config/starship.toml starship/starship.toml
#}}}

# Niri & Noctalia Configuration
backupAndReplace "$homedir"/.config/noctalia noctalia
backupAndReplace "$homedir"/.config/niri niri 

# GTK and Qt configuration
backupAndReplace "$homedir"/.config/gtk-3.0 gtk/gtk-3.0
backupAndReplace "$homedir"/.config/nwg-look/config nwg-look/config
backupAndReplace "$homedir"/.config/qt5ct qt/qt5ct
backupAndReplace "$homedir"/.config/qt6ct qt/qt6ct

# Kitty Configuration
backupAndReplace "$homedir"/.config/kitty/kitty.conf kitty/kitty.conf

# Vesktop Configuration
backupAndReplace "$homedir"/.config/vesktop/themes/noctalia.theme.css vesktop/noctalia.theme.css

# Dolphin Configuration
backupAndReplace "$homedir"/.config/dolphinrc dolphin/dolphinrc

# Steam Configuration
backupAndReplace "$homedir"/.local/share/Steam/steamui/skins/Material-Theme/css/main/colors/matugen.css steam/matugen.css

# Fastfetch Configuration
backupAndReplace "$homedir"/.config/fastfetch fastfetch

# Neovim Configuration
backupAndReplace "$homedir"/.config/neovim neovim


echo "Setup finished! Ensure that everything works correctly, and manually fix any problems."
