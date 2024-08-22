shopt -s expand_aliases
# myaliases

##########################
# monitoring and sysinfo #
##########################
alias hdtemp="sudo hddtemp /dev/sda"
alias rr="file /var/run/reboot-required"
alias sizes='sudo du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\' # sort filesystem items by size
alias mounts="mount | column -t"
alias diskusage="df -H -T $(mount | grep ext4 | cut -d' ' -f1)"
alias codename="lsb_release -rcs | tr '\n' ' '; echo"
alias ipsets="sudo ipset list -terse"
alias mygroups="id -nG"
alias bitos="getconf LONG_BIT"                                                                                                      # Cpu architecture
alias pstime="/usr/bin/time -v"                                                                                                     # Verbose process time
alias kernels="dpkg --list | grep linux-image"                                                                                      # Installed kernels
alias hwreport="sudo lshw -html > ~/hardware-report.html;xdg-open ~/hardware-report.html;sleep 3;sudo rm -f ~/hardware-report.html" # Create detailed hardware report including BIOS info in html format
alias hwreportshort="hwinfo --short"
alias portsps="ss -tp"             # Just like "ports" alias but with process names
alias bootline="cat /proc/cmdline" # Grub boot line
# w command: who is logged in and what is he doing?
alias zombies="ps aux | grep Z"
alias gwip="ip route | grep default | cut -d' ' -f3"                           # Gateway IP address
alias cores="nproc"                                                            # Number of cpu cores
alias tcolor="printf '\x1b[38;2;255;100;0mTRUECOLOR\x1b[0m\n'"                 # Truecolor test
alias ios="cat /sys/block/\$(mount | grep -w '/' | cut -c6-8)/queue/scheduler" # IO scheduler
alias timezone="timedatectl"
alias pstree2="ps -eo 'pid,args' --forest"                               # Process tree
alias cpugov="cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor" # Cpu scaling governor
alias ppas="sed -n '/deb .*ppa.launchpadcontent.net/ s@.*ppa.launchpadcontent.net/\(.*\)/ubuntu.*@\1@p' /etc/apt/sources.list.d/*.list"
alias fiotest="fio --name=random-write --ioengine=posixaio --rw=randwrite --bs=4k --numjobs=1 --size=4g --iodepth=1 --runtime=60 --time_based --end_fsync=1" # IO benchmark
# alias dnstat="systemd-resolve --statistics"
alias dnstat="echo 'This alias must be written using resolvectl and systemd-resolved must be in use by the system.'"
alias iotop="sudo iotop -oPa" # Disk IO usage since init of iotop.
alias iostatps="pidstat -d"   # pidstat can show lots of things about system usage. This one is IO read write by processes.
alias vnlive="vnstat -l 1"
alias free="free -mh" # Shows in 1024 format
alias clock="tty-clock -scrbC 3"
alias abrt="mysql -uadmin -ppassword -h 127.0.0.1 -e 'SHOW STATUS WHERE Variable_name LIKE \"Aborted_clients\"'" # Aborted MySQL/MariaDB clients
alias prcl="mysql -uadmin -ppassword -h 127.0.0.1 -e 'SHOW FULL PROCESSLIST'"                                    # MySQL/MariaDB process list
alias busy="lsof | { head -1 ; grep /media/\$(whoami) ; }"                                                       # Which process keeps the usb device busy
# alias iscoremodule="corelist --upstream" # Is this module in perl core?
#

##############################################
# archive management based on file extension #
##############################################
# I know this is not aliasing. I always forget that 'a'.
alias unpack="aunpack"
alias pack="apack"

###############################
# apt-get software management #
###############################
alias agu="sudo apt update -y"
alias agug="sudo apt upgrade -y"
alias agdu="sudo apt dist-upgrade -y"
alias agupdate="agu && agug && agdu"
alias agall="agupdate && agc && aga"
alias ags="apt search"
alias agc="sudo apt-get clean -y"
alias aga="sudo apt-get autoremove -y"
alias agi="sudo apt install -y"
alias agsh="apt show"
alias alu="apt list --upgradable"
alias ade="apt depends"                      # List dependencies of package
alias ader="apt-cache rdepends"              # List dependants (reverse dependencies) of package
alias aderi="apt-cache rdepends --installed" # List installed dependants (reverse dependencies) of package
alias aderio="aptitude why"                  # List installed dependants (reverse dependencies) of package in order

#####################
# shell environment #
#####################
alias srctm="tmux source-file ~/.tmux.conf"
alias mytmux="tmux attach -t mytmux"
# use bs() in .bash_functions instead of the below sourcebash
# alias sourcebash='source ~/.bashrc'
alias srcals="source ~/.bash_aliases"
# create parent dirs and be verbose about each created dir
alias mkdir="mkdir -pv"
alias op="xdg-open"
alias opd="op ./"  # Open current working directory
alias sudo="sudo " # This enables running aliases with sudo.
alias aswd="sudo -u www-data"
alias co="xclip -selection clipboard -i" # Copy text to GUI clipboard
alias pa="xclip -selection clipboard -o" # Echo text in system clipboard.

###################
# network related #
###################
alias ping="ping -c3"
# alias ports='netstat -tulanp'
alias ports="sudo lsof -i -n -P" # List of open ports
# alias myip='LANG=c ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}''
alias whatismyip="curl ifconfig.co" # WAN IP address
alias lip="hostname -I"             # Local IP address
alias iptall="sudo iptables -L -vn --line-numbers"
alias pyserver="python3 -m http.server 8080" # HTTP web server with Python
alias phpserver="phpo -S 0.0.0.0:8080"       # HTTP web server with PHP
alias phpo="php \
    -d opcache.enable=1 \
    -d opcache.enable_cli=1 \
    -d opcache.jit_buffer_size=256M \
    -d opcache.validate_timestamps=0 \
    -d opcache.fast_shutdown=1 \
    -d opcache.jit=tracing \
    -d mysqlnd.collect_statistics=0"
alias phphash="phpo ~/repos/php-playground/src/hash_algorithms_benchmark_time_length.php" # Benchmark PHP hashing algorithms
alias heyb="hey -n 100 -c 20"                                                             # HTTP Benchmark with hey
alias spd="speedtest --simple --no-upload"                                                # Download speed test
alias onl="sudo systemctl restart dnsmasq && sudo systemctl restart valet-dns"
alias metal="host metallica.com"
alias vnstatl='vnstat -l -i $(ip route | grep default | cut -d" " -f5)' # Monitor current gateway internet interface bandwidth

#######################################################################
#                     Use ssh host config instead                     #
#######################################################################
# ssh related aliases

######################
# virtualbox related #
######################
# alias vboxstart="VBoxManage startvm ubuntuserver160464-ready --type headless"
alias sshvm="ssh vagrant@192.168.1.20"

##########
#  MISC  #
##########
alias y2mp3="youtube-dl \
  --ignore-errors \
  --extract-audio \
  --audio-format 'mp3' \
  --audio-quality 320K \
  --output './%(title)s.%(ext)s' \
  --restrict-filenames \
  --prefer-ffmpeg \
  --metadata-from-title '%(artist)s - %(title)s' \
  "
alias qk="vim ~/.quick" # Open quick notes file in vim
alias weather="curl http://wttr.in/kayseri"
# alias mcon="sudo mount-containers"
# alias mcons="sudo mount-containers single"
# alias mconu="sudo conta --text --non-interactive -d"
alias mcon="mount-containers2"
alias cc="rm -rf ~/.cache/thumbnails/*"          # Clear thumbnail cache
alias nb="ip n | grep REACHABLE | cut -d' ' -f1" # Neighbors in the network
alias kssh="kitty +kitten ssh"
alias kssha="kssh \$(nb) -p 8022"              # Ssh into android
alias scpand="termscp \"\$(nb):8022:storage\"" # Scp file transfer with termscp to android
alias sniploc="cd ~/valet-park/sniploc; pws"
alias yt="ytfzf -T kitty -f -t"
alias update-kitty="curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin"
alias update-starship="curl -sS https://starship.rs/install.sh | sh -s -- -y"
alias update-wp="sudo wp cli update"    # Update wpcli, use 'wp cli check-update'
alias update-npm-global="npm update -g" # Update globally installed npm packages
alias str="vlc -vvv -I ncurses --recursive expand --quiet --random --sout '#http{mux=ts,dst=\$(hostname -I):8080/stream}' --sout-all --sout-keep /media/v*"
alias ger="mcon mount-only && sstart gerbera.service"
alias gers="sstop gerbera.service && cd ~ && sudo conta -d && cc"
alias uud="unmount-usb-drives"
alias die="uud; shutdown -h now"
alias killdnsm="sudo killall -s SIGKILL dnsmasq"
alias q="exit"
alias rstcgo="rstc go && sleep 3 && uud && sleep 3 && die"                                    # Backup with rstc and shutdown
alias upv="cd ~/repos/v; v up; v doc -m -f html vlib/; cd ~/Documents/vlang/docs/; git pull;" # Update vlang source, api reference and docs

##############
#  Composer  #
##############
alias phpoc="phpo -n -dextension=phar.so -dextension=iconv.so /usr/bin/composer"
alias cgu="composer global update" # Update globally installed packages
# alias cdo="composer dump-autoload --optimize"
# alias cgs="composer global show" # List globally installed packages
# alias csu="sudo composer self-update" # Upgrade composer
alias cdo="phpoc dump-autoload --optimize"
alias cgs="phpoc global show"                                                                  # List globally installed packages
alias csu="sudo php -n -dextension=phar.so -dextension=iconv.so /usr/bin/composer self-update" # Upgrade composer
alias csd="phpoc show --direct"                                                                # List required packages of root package
alias cse="phpoc search"                                                                       # Search for composer packages
alias cre="composer require"                                                                   # Install composer package

###########
# Laravel #
###########
artisan() {
  if [ -f bin/artisan ]; then
    php bin/artisan "$@"
  else
    php artisan "$@"
  fi
}

alias serve="artisan serve"
alias tinker="artisan tinker"
alias laravel-installer="composer create-project --prefer-dist laravel/laravel"
alias dbreset="php artisan migrate:reset && php artisan migrate --seed"

#####
#Git#
#####
alias grevert="git reset --hard && git clean -df"                                                                                          # Revert to last commit
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # Git log prettified
alias gwip="git add . && git commit -m 'wip'"
alias garchive="git archive -o ~/latest.zip HEAD"
alias gpush="git push"
alias gcommit="git add -u && git commit -m"
alias gstat="git status"
alias glist="git ls-tree -r main --name-only" # List git tracked files
alias gcm="git checkout main"
alias dfiles="/usr/bin/git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME" # Dotfiles management with git
alias ddiff="dfiles diff"
alias dcommit="dfiles add -u && dfiles commit -m"
alias dstat="dfiles status"
alias dpush="dfiles push -u gitlab_remote main"
alias dpushgh="dfiles push -u github_remote main"
alias dpushall="dpush && dpushgh"
alias darchive="dfiles archive -o dotfiles-gitlab-repo.zip HEAD"
alias dlog="dfiles log"
alias drevert="dfiles reset --hard HEAD" # Revert changes to last commit of dotfiles

#########################
#  Docker and Devilbox  #
#########################
alias develup="docker-compose up -d httpd php mysql"
alias develdown="docker-compose down"

# glow.yml config does not support pager option, for now
alias glow="glow -p" # Markdown viewer in cli
alias slideshow="feh --recursive --auto-zoom -F --slideshow-delay 4 --randomize"

# systemctl
# alias sc=systemctl
# alias scu='systemctl --user'

# Subcommands
alias sstart="sudo systemctl start"
alias sstop="sudo systemctl stop"
alias sreload="sudo systemctl reload"
alias srestart="sudo systemctl restart"
alias senable="sudo systemctl enable"
alias sdisable="sudo systemctl disable"
alias slemp="sstart php\$(phv)-fpm nginx mariadb redis-server" # Start LEMP
alias snt="sudo nginx -t"

alias sstatus="systemctl status"
alias sshow="systemctl show"
alias sunits="systemctl list-units"
alias sunitfiles="systemctl list-unit-files"
alias stimers="systemctl list-timers"
alias scat="systemctl cat"
alias sedit="sudo systemctl edit"
alias senabled="systemctl is-enabled"

alias phv="php -n -r \"printf('%d.%d', PHP_MAJOR_VERSION, PHP_MINOR_VERSION);\"" #
alias srp="srestart php\$(phv)-fpm"
# alias srp="srestart php\$(php -r \"printf('%d.%d', PHP_MAJOR_VERSION, PHP_MINOR_VERSION);\")-fpm"
alias srn="srestart nginx"
alias sro="srestart lshttpd" # Restart openlitespeed
alias srm="srestart mariadb"
alias srh="srestart haproxy"
alias srl="srestart lighttpd"
alias srv="srestart varnish"

alias oops="sudo \$(fc -ln -1)"

alias f=floaterm # Use f inside floaterm windows in vim to open files.
