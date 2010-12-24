#!/bin/bash
set -e

sources=(config/.bashrc config/.vimrc config/.gitconfig config/.ctags)
destinations=(~/.bashrc ~/.vimrc ~/.gitconfig ~/.ctags)
count=${#sources[@]}
if [ $count -ne ${#destinations[@]} ]
then 
	echo "UH OH, destinations and sources don't match length! quitting"
	exit 1
fi

currDir=`pwd`
for ((i=0; i<count; i+=1))
do
	s=$currDir/${sources[$i]}
	if [ ! -e $s ]
	then
		echo "UH OH, no file $s in environment! skipping..."
		continue
	fi
	d=${destinations[$i]}
	echo -n $d
	if [ -e $d ]
	then 
		if [ $d -ef $s ]
		then echo " already linked to environment"
		else echo " already exists! skipping. just rm it and run this again."
		fi
	else
		ln -s $s $d
		echo " linked from $d"
	fi
done
