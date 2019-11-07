#!/bin/bash 

SESSION="RequiredServices"

tmux new-session -d -s $SESSION

tmux new-window -t $SESSION:1 -n 'MariaDB'      
tmux send-keys "/usr/bin/mysqld_safe --basedir=/usr" C-m

tmux new-window -t $SESSION:2 -n 'Munge'
tmux send-keys "sudo -u munge /usr/sbin/munged -F" C-m

tmux new-window -t $SESSION:3 -n 'Prepare'
tmux send-keys "sleep 5" C-m
tmux send-keys "echo 'create database slurm' | mysql" C-m
tmux send-keys "echo \"GRANT ALL PRIVILEGES ON *.* TO 'slurm'@'localhost' IDENTIFIED BY 'password';\" | mysql" C-m

tmux -2 attach-session -t $SESSION

tail -f /var/log/mariadb/mariadb.log
