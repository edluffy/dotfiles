if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)apt.sh starting package install for linux-gnu."
	sudo -v 

	sudo apt-get update
	sudo apt-get upgrade
	xargs -a packages/Aptfile sudo apt-get install

	chsh -s /bin/zsh
	echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 2)apt.sh finished installing packages"

else
	echo -e "$(tput bold)$(tput setaf 5)  Dotfiles: $(tput setaf 3)apt.sh exited, system is not linux-gnu."
fi
