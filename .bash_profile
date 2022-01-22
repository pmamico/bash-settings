#######################################
## .bash_profile for my main desktop ##
#######################################

## Prompt style ##
export PS1="\[\033[38;5;10m\][\w]\[$(tput sgr0)\]\[\033[38;5;194m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')\[$(tput sgr0)\]:\[$(tput sgr0)\]\[\033[38;5;11m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LANG=en_US.UTF-8

## eternal bash history with time ##
# 37  [2022-01-22 12:14:41] ls
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTFILE=~/.bash_eternal_history
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
echo "eternal history enabled"

## Useful env ## 
# for manual backups, db dump etc.
export TODAY=$(date +%Y_%m_%d)
export BASH_SILENCE_DEPRECATION_WARNING=1

## lsf command ##
# ls 
# octal (numeric) permission
# only visible files
lsf() { gls -lh --time-style=iso --color "$@" | awk '{filename=""; for(i=8;i<=NF;i++){filename = filename" "$i};k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print("("$3") \t"$5"\t "$6"  "$7"\t"filename)}' | sed 1d; } 

## lsh command ##
# ls 
# only hidden files
# octal (numeric) permission
lsh() { gls -lhd --time-style=iso --color .?* "$@" | awk '{filename=""; for(i=8;i<=NF;i++){filename = filename" "$i};k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print("("$3") \t"$5"\t "$6"  "$7"\t"filename)}'; } 
alias ls.="lsh"

## for macOs ##
alias ftp='ncftp '
alias tc='open -a Commander\ One $(pwd)'
# z, https://github.com/rupa/z
# real game changer!
if command -v brew >/dev/null 2>&1; then
	# Load rupa's z if installed
	[ -f $(brew --prefix)/etc/profile.d/z.sh ] && source $(brew --prefix)/etc/profile.d/z.sh
fi
# open ports
ports(){netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print cred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"}

## Music ##
alias spotify='ncspot'

## Web Development ##
# Glassfish and Payara 1 hour timeout (eg. deploy)
export AS_ADMIN_READTIMEOUT="3600000"

## Cloud development ##
export HELM_EXPERIMENTAL_OCI=1

## if using td (https://github.com/Swatto/td)
export TODO_DB_PATH=$HOME/todo.json
td list

## everyday alias ##
xml2html() { file_name=${1%".xml"}; xsltproc $1 -o $file_name.html; }
alias x2h='xml2html '
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias calc='bc'
# resume getting a partially-downloaded file
alias wget='wget -c'
tcp(){sudo tcpdump -i en0 host $1 and $2}