# Nick's Environment

This is my environment, a set of scripts and configs I use to make life a little easier.

I have this checked out and add the bin directory to my path and symlink the config files from where the system expects them.  For exmaple

	$ ln -s ~/environment/config/.gitconfig ~/.gitconfig
	$ ln -s ~/environment/config/.bashrc ~/.bashrc
	$ ln -s ~/environment/config/.vimrc ~/.vimrc

Then I've got my environment set up. Doing this manually is not necessary; see Installation below.

## Installing

There is a handy install.sh script that will install the necessary files.  This script will create symbolic links from the locations where the various config files should live to their environment sources.
