# Additions to Path
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/opt/bin

#export PATH=$PATH:$HOME/bin

# Mysql DB
export PATH=$PATH:/usr/local/mysql/bin
export MANPATH=$MANPATH:/usr/local/mysql/man

# Oracle Instant Client
# export ORACLE_HOME=/opt/oracle/instantclient_10_2-32bit
# export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$ORACLE_HOME
# export SQLPATH=$ORACLE_HOME
# export TNS_ADMIN=$ORACLE_HOME/network/admin
# export NLS_LANG=AMERICAN_AMERICA.UTF8
# export PATH=$PATH:$ORACLE_HOME

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
