# Nick's Environment

This is my environment, a.k.a. dotfiles, a set of scripts and configs I use to make life a little easier.

I have this checked out and add the bin directory to my path and symlink the config files from where the system expects them.  For exmaple

	$ ln -s ~/environment/config/.gitconfig ~/.gitconfig
	$ ln -s ~/environment/config/.bashrc ~/.bashrc
	$ ln -s ~/environment/config/.vimrc ~/.vimrc

Then I've got my environment set up. Doing this manually is not necessary; see Installation below.

## Installing

There is a handy install.sh script that will install the necessary files.  This script will create symbolic links from the locations where the various config files should live to their environment sources.

### Extra Install Steps

some other packages that are useful:

```
sudo apt install make gawk clang silversearcher-ag dstat pv xscreensaver xss-lock xclip feh rbenv xdotool dunst vim-gtk lxqt-policykit brightnessctl
```

headphone plug/unplug handling needs to be done as root:

```
sudo cp config/headphone_jack /etc/acpi/events/
sudo cp bin/headphone_jack.sh /etc/acpi/
sudo chmod +x /etc/acpi/headphone_jack.sh
sudo service acpid restart
```

put some useful folders with lowercase names:
```
mv ~/Downloads ~/downloads && ln -s ~/downloads ~/Downloads
mv ~/Videos ~/videos && ln -s ~/Videos ~/videos
```

create a `~/.background` file which should be an image loadable by feh

add user to some groups
```
sudo groupadd nick video
sudo groupadd nick input
sudo groupadd nick dialout
```

Extra config files:

* `config/dwm.desktop` goes in `/usr/share/xsessions/dwm.desktop`
* `config/000_lock_screensaver` goes in `/usr/lib/pm-utils/sleep.d/`
* `config/NetworkManager_dispatcher.d/*` goes in `/etc/NetworkManager/dispatcher.d/`
* `config/udev/*` goes in `/etc/udev/rules.d`
