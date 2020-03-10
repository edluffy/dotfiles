# Ask for administrator passowrd
sudo -v 

################### MAC SETUP ####################
if [ "$(uname)" == "Darwin" ]; then
	echo -e "\n====== Starting Bootstrapping for Mac! ======\n"

	if test ! $(which brew); then
	  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	fi

	#brew remove --force $(brew list) # optional purge
	brew doctor
	brew update
	brew bundle --no-lock --file packages/Brewfile
fi

################### LINUX SETUP ####################

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	echo -e "\n====== Starting Bootstrapping for Linux! ======\n"

	sudo apt-get update
	sudo apt-get upgrade

	xargs -a packages/Aptfile sudo apt-get install
fi

echo -e "\n====== Bootstrapping Finished! ======\n"
echo
echo "Enjoy - edluffy"
