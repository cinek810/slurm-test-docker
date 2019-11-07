FROM centos:7
RUN yum -y install epel-release 
RUN yum -y install mariadb mariadb-devel mariadb-server tmux munge munge-devel\
    sudo vim gcc make git lua-devel man

COPY munge.key /etc/munge/munge.key

RUN chown munge /etc/munge/munge.key && chmod 0400 /etc/munge/munge.key ; \
    mysql_install_db --user=mysql --ldata=/var/lib/mysql --force; \
    mkdir /etc/slurm
    

COPY start.sh /start.sh

COPY slurm/slurm.conf /etc/slurm/slurm.conf
COPY slurm/slurmdbd.conf /etc/slurm/slurmdbd.conf
COPY slurm/cgroup.conf /etc/slurm/cgroup.conf
COPY slurm/prolog.sh /etc/slurm/prolog.sh
COPY slurm/epilog.sh /etc/slurm/epilog.sh
COPY slurm/prologSlurmctl.sh /etc/slurm/prologSlurmctl.sh
COPY slurm/healthcheck.sh /etc/slurm/healthcheck.sh
COPY slurm/job_submit.lua /etc/slurm/job_submit.lua

ENTRYPOINT /start.sh
