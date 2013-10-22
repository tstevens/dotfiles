alias l='ls -l'
alias zm='zless'
alias mv="mv -i"
alias cp="cp -i"
alias diff=colordiff
alias rm="rm -i"

alias m="less"
alias qu="quota -v"

alias d="dirs"
# alias up='cd $cwd:h ; pwd'
# alias ul='cd $cwd:h ; pwd; ls'
# alias cl='cd \!\!*; pwd ; ls'

alias slay="kill -9"
alias compress="compress -v"

alias mkdir="mkdir -vp"
alias pwn='sudo -i'

alias randpass='egrep -ioam1 '[a-z0-9]{8}' /dev/urandom'

alias webshare='python -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

alias showdns='scutil --dns'

alias showroutes='netstat -rn'

alias flushdns='dscacheutil -flushcache'

#less tail ^C to interrupt tailing and resume with shift-f
alias lt='less +F'


# alias reverselocaldns='dig +short -x \!:1 @224.0.0.251 -p 5353'

# alias dfind='mdfind -onlyin .'