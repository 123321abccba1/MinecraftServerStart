# /bin/bash

if [[ "$#" -eq 0 ]]; then
    echo "Please provide tmux sesson name"
    exit 1
    fi
result="$(echo $1 | sed 's/[^[:alnum:]]//g')"   
if [ "$result" != "$1" ]; then
            echo "Not valid tmux name"       #notvalid
            exit 2
        fi
filepath=$( pwd )
ismcdr=$( ls server|grep -E "jar" )
create=$(tmux new-session -s $1 -n editor -d)
if [[ $ismcdr != "" ]]; then
    tmux send-keys -t $1 "cd ${filepath} && mcdreforged " C-m
else
    isbash=$( ls |grep -E "start.sh" )
    if [[ $isbash != "" ]]; then
        tmux send-keys -t $1 "cd ${filepath} && ./start.sh" C-m
        else
        filename=$(ls | grep -E ".jar")
        tmux send-keys -t $1 "cd ${filepath} && java -jar $filename " C-m
    fi
fi
tmux has-session -t $1 2>/dev/null
if [[ $? -eq 0 ]]; then
    echo "$1"
    exit 0
else
    echo "Can not create tmux session"
    exit 1
fi
    
