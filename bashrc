# Check if shell is interactive
if [ -z "$PS1" ]; then
   return
fi

# Additions to Path
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

#Add vmware tools: vmrun vmnet-sniffer ovftool etc
if [ -f /opt/vmware/vm ]; then
    . /opt/vmware/vm
fi

# Moved from bash_profile.. dont need this unless interactive
# Add xcode developer tools perl libraries to perl path
# required for git-svn to find perl svn libraries
# http://lifeandcode.net/2012/02/using-git-svn-on-os-x-10-8-developer-preview/
# http://blog.victorquinn.com/fix-git-svn-in-mountain-lion
#XCODE_CLI_TOOLS=$(xcode-select --print-path)
# PERL_VERSION=$(perl -e 'print "$^V";' | sed -e '1s/^.//' | sed 's/\(.*\)../\1/')
# PERL_ARCH=$(perl -V:archname | awk -F\' '{c[$2]++} END{for (w in c) print w}')
# export PERL5LIB=$XCODE_CLI_TOOLS/Library/Perl/$PERL_VERSION/$PERL_ARCH
#export PERL5LIB=$XCODE_CLI_TOOLS/Library/Perl/5.16/darwin-thread-multi-2level

# History control
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="exit:clear:pwd"
export HISTFILESIZE=9000
shopt -s histappend
shopt -s cdspell
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

#export PATH=$PATH:/opt/vmdk/bin

# Paths and Editor
if test "$SSH_CONNECTION" != ""; then
    export EDITOR="/usr/bin/vim"
elif [ -f /usr/local/bin/mate ]; then
    export EDITOR="/usr/local/bin/mate -w"
else
    export EDITOR="/usr/bin/vim"
fi

if [ -f /usr/bin/less ]; then
    export PAGER="/usr/bin/less"
fi

set -o noclobber # prevent overwriting files -- use |> to ignore for a single operation
# set -o ignoreeof # stops ctrl+d from logging out

# ls colored output for dark backgrounds
export CLICOLOR=true
export LSCOLORS=dxfxcxdxbxegedabagacad

# grep colored output
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;35'

# JAVA_HOME http://stackoverflow.com/questions/1348842/what-should-i-set-java-home-to-on-osx
export JAVA_HOME=$(/usr/libexec/java_home)

# ant colored output
# http://stackoverflow.com/questions/1790827/problem-with-ants-ansicolorlogger-in-snow-leopard
export ANT_ARGS='-logger org.apache.tools.ant.listener.AnsiColorLogger'
export ANT_OPTS="-Dbuild.compiler=org.eclipse.jdt.core.JDTCompilerAdapter -Dant.logger.defaults=${HOME}/.antcolors"

# Aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Bash Completion
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi
complete -cf sudo #Tab complete for sudo

# Git prompt
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion.d/git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=true
    GIT_PS1_SHOWUNTRACKEDFILES=true
    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWUPSTREAM="auto verbose"
    PS1='\h:\W$(__git_ps1 " (%s)") \u\$ '
fi

# if [ -f /usr/local/etc/autojump.sh ]; then
#     . /usr/local/etc/autojump.sh
# fi

#GPG pin entry ssh http://support.gpgtools.org/kb/faq/how-to-enter-your-passphrase-directly-in-the-terminal
if test "$SSH_CONNECTION" != ""; then
     export PINENTRY_USER_DATA="USE_CURSES=1"
fi


function size() { du -sh "$@" ;}

###   Handy Extract Program
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar --use-compress-program pbunzip2 -xvf  $1        ;;
            *.tar.gz)    tar --use-compress-program unpigz -xvf  $1     ;;
            *.bz2)       pbunzip2 $1       ;;
            *.rar)       unrar x $1     ;;
            *.gz)        unpigz $1     ;;
            *.tar)       tar xvf $1        ;;
            *.tbz2)      tar --use-compress-program pbunzip2 -xvf $1      ;;
            *.tgz)       tar --use-compress-program unpigz -xvf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

lmv() { [ -e "$1" -a -d "$2" ] && mv "$1" "$2"/ && ln -s "$2"/"$(basename "$1")" "$(dirname "$1")"; }

revlocaldns() { dig +short -x $1 @224.0.0.251 -p 5353;}

#new ssl key and csr based on a previous ssl certificate
#regenerateCSR original.crt new.key new.csr
regenerateCSR () { openssl genrsa -out $2 2048; openssl x509 -x509toreq -in $1 -out $3 -signkey $2; }

translate(){ wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/'; }

f2iso () { hdiutil makehybrid -o ./$1.iso $1; }

hide () { chflags hidden $1; }
show () { chflags nohidden $1; }
