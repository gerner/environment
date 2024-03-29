#!/bin/bash
set -e

# config sources and destinations parallel arrays
s1="config/.bashrc config/.vimrc config/.gitconfig config/.ctags config/ssh_config config/.gitignore_global config/.xscreensaver config/.tmux.conf config/.bcrc config/.inputrc config/.xsessionrc config/awk/date.awk config/awk/reduce.awk config/awk/sumcols.awk config/awk/stats.awk config/awk/groupstats.awk config/awk/hist.awk config/dunstrc"
d1="$HOME/.bashrc $HOME/.vimrc $HOME/.gitconfig $HOME/.ctags $HOME/.ssh/config $HOME/.gitignore_global $HOME/.xscreensaver $HOME/.tmux.conf $HOME/.bcrc $HOME/.inputrc $HOME/.xsessionrc $HOME/.awk/date.awk $HOME/.awk/reduce.awk $HOME/.awk/sumcols.awk $HOME/.awk/stats.awk $HOME/.awk/groupstats.awk $HOME/.awk/hist.awk $HOME/.config/dunst/dunstrc"

linkDestinationsToSources() {
        warning=
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
                warning=1
                continue
            fi
            d=${destinations[$i]}
            if [ ! -e $d ] && [ -h $d ]; then
                rm $d
            fi
            echo -n "$d"
            if [ -e $d ]; then 
                if [ $d -ef $s ]; then
                    echo " already linked to environment"
                else
                    echo " already exists! skipping. just rm it and run this again."
                    warning=1
                fi
            else
                #first make sure we have the relevant directory
                mkdir --parents $(dirname "$d")
                #then create a symlink to our config file so it stays under version control
                ln -s $s $d
                echo " linked from $d"
            fi
        done
}

#first link the configs
echo "linking configs..."
linkDestinationsToSources "$s1" "$d1"

if [ ! -z "$warning" ]; then echo ""; echo "There are warnings above!"; fi

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
echo ""
echo "linking binaries..."
linkDestinationsToSources "$s" "$d"
if [ ! -z "$warning" ]; then echo ""; echo "There are warnings above!"; fi
