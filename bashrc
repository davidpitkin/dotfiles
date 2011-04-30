# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

#       _           _  _          __
#  ___ | |__   ___ | || |        / _| _   _      ___  _ __  __ _
# / __|| '_ \ / _ \| || | _____ | |_ | | | |    / _ \| '__|/ _` |
# \__ \| | | |  __/| || ||_____||  _|| |_| | _ | (_) | |  | (_| |
# |___/|_| |_|\___||_||_|       |_|   \__,_|(_) \___/|_|   \__, |
#                                                   .bashrc|___/
#
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# cdpath - http://www.shell-fu.org/lister.php?id=185
export CDPATH='.:~:/sto'


# directory tree - http://www.shell-fu.org/lister.php?id=209
alias dirf='find . -type d | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"'


#compare files using comm (requires perl) - http://www.shell-fu.org/lister.php?id=186
compare(){
  comm $1 $2 | perl -pe 's/^/1: /g;s/1: \t/2: /g;s/2: \t/A: /g;' | sort
}


#calendar with today highlighted - http://www.shell-fu.org/lister.php?id=210
alias tcal='cal | sed "s/^/ /;s/$/ /;s/ $(date +%e) / $(date +%e | sed '\''s/./#/g'\'') /"'


# count files by type - http://www.shell-fu.org/lister.php?id=173
alias ftype='find ${*-.} -type f | xargs file | awk -F, '\''{print $1}'\'' | awk '\''{$1=NULL;print $0}'\'' | sort | uniq -c | sort -nr'


# convert permissions to octal - http://www.shell-fu.org/lister.php?id=205
alias lo='ls -l | sed -e 's/--x/1/g' -e 's/-w-/2/g' -e 's/-wx/3/g' -e 's/r--/4/g' -e 's/r-x/5/g' -e 's/rw-/6/g' -e 's/rwx/7/g' -e 's/---/0/g''


# portscan in one line - http://www.shell-fu.org/lister.php?id=295
portscan(){
  HOST="$1";for((port=1;port<=65535;++port));do echo -en "$port ";if echo -en "open $HOST $port\nlogout\quit" | telnet 2>/dev/null | grep 'Connected to' > /dev/null;then echo -en "\n\nport $port/tcp is open\n\n";fi;done
}


# print a random shell-fu tip - http://www.shell-fu.org/lister.php?id=192
alias shell-fu='links -dump "http://www.shell-fu.org/lister.php?random" | grep -A 100 -- ----'


# get an ordered list of subdirectory sizes - http://www.shell-fu.org/lister.php?id=275
alias dux='du -sk ./* | sort -n | awk '\''BEGIN{ pref[1]="K"; pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'\'''


# share current tree over the web - http://www.shell-fu.org/lister.php?id=54
alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'


# overwrite a file with zeroes - http://www.shell-fu.org/lister.php?id=94
zero() {
  case "$1" in
    "")     echo "Usage: zero <file>"
            return -1;
  esac
  filesize=`wc -c  "$1" | awk '{print $1}'`
  dd if=/dev/zero of=$1 count=$filesize bs=1
}


# keep your home directory organised - http://www.shell-fu.org/lister.php?id=310
export TD="$HOME/temp/`date +'%Y-%m-%d'`"
td(){
    td=$TD
    if [ ! -z "$1" ]; then
        td="$HOME/temp/`date -d "$1 days" +'%Y-%m-%d'`";
    fi
    mkdir -p $td; cd $td
    unset td
}


# create a terminal calculator - http://www.shell-fu.org/lister.php?id=216
calc(){ echo "${1}"|bc -l; }


# copy and paste from the command line - http://www.shell-fu.org/lister.php?id=177
ccopy(){ cp $1 /tmp/ccopy.$1; }
alias cpaste="ls /tmp/ccopy* | sed 's|[^\.]*.\.||' | xargs -I % mv /tmp/ccopy.% ./%"


# bash function to decompress archives - http://www.shell-fu.org/lister.php?id=375
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1        ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar xvjf $1      ;;
            *.tgz)       tar xvzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


######################### Additional Aliases #########################
alias l='ls -alF'
alias ll='ls -alF'
alias dir='ls -la'
alias la='ls -Fa'
alias ld='ls -al -d * | egrep "^d"' # only subdirectories
alias lt='ls -alt | head -20' # recently changed files

alias md='mkdir -p'
alias rd=rmdir
alias ..='cd ..'
alias ...='cd ../..'
alias +='pushd .'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gd='git diff | mate'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
# Bash Directory Bookmarks
alias m1='alias g1="cd `pwd`"'
alias m2='alias g2="cd `pwd`"'
alias m3='alias g3="cd `pwd`"'
alias m4='alias g4="cd `pwd`"'
alias m5='alias g5="cd `pwd`"'
alias m6='alias g6="cd `pwd`"'
alias m7='alias g7="cd `pwd`"'
alias m8='alias g8="cd `pwd`"'
alias m9='alias g9="cd `pwd`"'
alias mdump='alias|grep -e "alias g[0-9]"|grep -v "alias m" > ~/.bookmarks'
alias lma='alias | grep -e "alias g[0-9]"|grep -v "alias m"|sed "s/alias //"'
touch ~/.bookmarks
source ~/.bookmarks

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
tail -n3 /sto/log/s3sync.log

