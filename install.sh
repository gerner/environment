#!/bin/bash
set -e
#set -x

s1="config/.bashrc config/.vimrc config/.gitconfig config/.ctags config/ssh_config config/.gitignore_global"
d1="$HOME/.bashrc $HOME/.vimrc $HOME/.gitconfig $HOME/.ctags $HOME/.ssh/config $HOME/.gitignore_global"

linkDestinationsToSources() {
		if [[ -z $1 || -z $2 ]]
		then
			echo "need sources destinations! s: $1 d: $2"
			exit 1
		fi

		sources=( `echo "$1"` )
		destinations=( `echo "$2"` )
		count=${#sources[@]}

		if [ $count -ne ${#destinations[@]} ]
		then 
			echo "UH OH, destinations and sources don't match length! quitting"
			echo ${sources[@]}
			echo ${destinations[@]} 
			echo $count ${#destinations[@]}
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
			echo -n "$d"
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
}

#first link the configs
echo "linking configs..."
linkDestinationsToSources "$s1" "$d1"

#then link the executables to ~/bin

#make sure ~/bin exists
if [[ ! -d ~/bin ]]
then
	if [[ -e ~/bin ]]
	then
		echo "UH OH, ~/bin exists, but isn't a directory!"
		exit 1
	else
		echo "creating ~/bin..."
		mkdir ~/bin
	fi
fi

s=`find bin/ -executable -type f`
s_array=( `echo "$s"` )
d=""
count=${#s_array[@]}
for ((i=0; i<count; i+=1))
do
	d="$d $HOME/${s_array[$i]}"
done
echo "linking binaries..."
linkDestinationsToSources "$s" "$d"
