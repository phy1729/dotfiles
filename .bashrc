# set -o vi
set -o noclobber

alias odd='od -c -t x1'
alias v='vim'
alias c='ssh c'

case $(uname -s) in
	Darwin)
		alias ls='ls -AehlFWO'
		alias brewup='brew update; brew upgrade'
		alias scd='. ~/bin/scd'
		alias note='scd; vim notes.tex'
		;;
	Linux|OpenBSD)
		alias ls='ls -AhlF'
		function say { mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=$1"; }
		alias playdir="mplayer -shuffle -playlist <(find -L \"`pwd`\" -type f)"
		;;
esac


function cvtun { ssh -N phy1729@n.collegiumv.org -L 22`printf "%02d" $1`:192.168.42.$1:$2; }
function ssh-copy-id { cat ~/.ssh/id_dsa.pub | ssh $1 'cat >> ~/.ssh/authorized_keys'; }
# map :h to opening vim's help in fullscreen
function :h () { vim +"h $1" +only; }


# Define prompt
# From http://tldp.org/LDP/abs/html/sample-bashrc.html

# Define some colors
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Cyan='\e[0;36m'         # Cyan
BRed='\e[1;31m'         # Red Bold
BWhite='\e[1;37m'       # White Bold
On_Red='\e[41m'         # Red Background
ALERT=${BWhite}${On_Red} # Bold White on red background

NC="\e[m"               # Color Reset

# Current Format: USER@HOST:PWD$
# HOST:
#    Green     == machine load is low
#    Orange    == machine load is medium
#    Red       == machine load is high
#    ALERT     == machine load is very high
# PWD:
#    Green     == more than 10% free disk space
#    BRed      == less than 10% free disk space
#    ALERT     == less than 5% free disk space
#    Red       == current user does not have write privileges
#    Cyan      == current filesystem is size zero (like /proc)
#
#    Command is added to the history file each time you hit enter,
#    so it's available to all shells (using 'history -a').


#NCPU=$(grep -c 'processor' /proc/cpuinfo)    # Number of CPUs
case $(uname -s) in
	Darwin|OpenBSD)
		NCPU=$(sysctl -n hw.ncpu)
		;;
	Linux)
		NCPU=$(grep -c 'processor' /proc/cpuinfo)
		;;
esac

SLOAD=$(( 100*${NCPU} ))	# Small load
MLOAD=$(( 200*${NCPU} ))	# Medium load
XLOAD=$(( 400*${NCPU} ))	# Xlarge load

# Returns system load as percentage, i.e., '40' rather than '0.40)'.
function load()
{
	case $(uname -s) in
		Darwin)
			local SYSLOAD=$(sysctl -n vm.loadavg | cut -d " " -f2 | tr -d '.')
			;;
		Linux)
			local SYSLOAD=$(cut -d " " -f1 /proc/loadavg | tr -d '.')
			;;
		OpenBSD)
			local SYSLOAD=$(sysctl -n vm.loadavg | cut -d " " -f1 | tr -d '.')
			;;
	esac
	# System load of the current host.
	echo $((10#$SYSLOAD))	   # Convert to decimal.
}

# Returns a color indicating system load.
function load_color()
{
	local SYSLOAD=$(load)
	if [ ${SYSLOAD} -gt ${XLOAD} ]; then
		echo -en ${ALERT}
	elif [ ${SYSLOAD} -gt ${MLOAD} ]; then
		echo -en ${Red}
	elif [ ${SYSLOAD} -gt ${SLOAD} ]; then
		echo -en ${BRed}
	else
		echo -en ${Green}
	fi
}

# Returns a color according to free disk space in $PWD.
function disk_color()
{
	if [ ! -w "${PWD}" ] ; then
		echo -en ${Red} # No 'write' privilege in the current directory.
	elif [ -s "${PWD}" ] ; then
		local used=$(command df -P "$PWD" | awk 'END {print $5} {sub(/%/,"", $5)}')
		if [ ${used} -gt 95 ]; then
			echo -en ${ALERT}	# Disk almost full (>95%).
		elif [ ${used} -gt 90 ]; then
			echo -en ${BRed}	# Free disk space almost gone.
		else
			echo -en ${Green}	# Free disk space is ok.
		fi
	else
		echo -en ${Cyan} # Current directory is size '0' (like /proc, /sys etc).
	fi
}


# Now we construct the prompt.
PROMPT_COMMAND="history -a"
case ${TERM} in
  *term | rxvt | linux | xterm-256color | screen-256color)
		PS1="\u@\[$(load_color)\]\h\[${NC}\]:"
		PS1=${PS1}"\[$(disk_color)\]\w\[${NC}\]\$ "
		;;
	*)
		PS1="\u@\h:\w\$ "
		;;
esac
