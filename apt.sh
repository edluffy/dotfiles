################### LINUX SETUP ####################

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	echo -e "\n====== Starting Package install for Linux! ======\n"
	sudo -v 

	sudo apt-get update
	sudo apt-get upgrade
	xargs -a packages/Aptfile sudo apt-get install

	chsh -s /bin/zsh
fi

echo -e "\n====== Finished, enjoy - edluffy ======\n"
