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

**Packages**

```
sudo apt install make gawk clang silversearcher-ag dstat pv xscreensaver \
    xss-lock xclip feh rbenv xdotool dunst vim-gtk3 lxqt-policykit \
    brightnessctl cmake ninja-build libao4 libcrypto++-dev libgcrypt20-dev \
    libcurl4-openssl-dev jq libxft-dev libxinerama-dev acpitool pamixer
```

**Standard Folders**

put some useful folders with lowercase names:
```
mv ~/Downloads ~/downloads && ln -s ~/downloads ~/Downloads
mv ~/Videos ~/videos && ln -s ~/Videos ~/videos
```

**Desktop Background**

create a `~/.background` file which should be an image loadable by feh

**User Groups**

add user to some groups
```
sudo usermod -a -G video nick\
sudo usermod -a -G input\
sudo usermod -a -G dialout\
sudo usermod -a -G plugdev nick
```

**More Config Files**

These are not handled by install.sh since they are system-wide and need to be
run by root.

* DWM as a window manager: `config/dwm.desktop` goes in `/usr/share/xsessions/dwm.desktop`
* Lock screen on suspend: `config/000_lock_screensaver` goes in `/usr/lib/pm-utils/sleep.d/`
* Network Manager configs: `config/NetworkManager_dispatcher.d/*` goes in `/etc/NetworkManager/dispatcher.d/`
  * set timezone using internet on connecting to a network
* `config/udev/*` goes in `/etc/udev/rules.d`
  * expose radios on sensible `/dev/` names
  * stuff for flipper zero
  * make /sys/ leds and backlight owned by `backlight` and `leds` groups, so users can change them without sudo
  * make Arduino Uno R4 serial port owned by `plugdev` group so users can flash without sudo
  * treat RT Systems cables (radio programming cables) as FTDI cables by loading `ftdi_sio` kernel module for them

### Old Stuff

Not really used any more, but could.

**Set Volume on Headphone Un/Plug**

headphone plug/unplug handling needs to be done as root:

```
sudo cp config/headphone_jack /etc/acpi/events/
sudo cp bin/headphone_jack.sh /etc/acpi/
sudo chmod +x /etc/acpi/headphone_jack.sh
sudo service acpid restart
```

