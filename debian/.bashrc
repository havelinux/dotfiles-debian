# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [ "$PS1" ] ; then

    # Color para grep y para el prompt:
    export TERM=xterm-color
    export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'

    # Muestra la rama de git en el prompt:
    function parse_git_dirty {
        [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
    }
    function parse_git_branch {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
    }
    export PS1='\[\e[1;32m\][\w\[\e[1;33m\]$(parse_git_branch)\[\e[1;32m\]]\n> \[\e[0m\]'
    export PS2='> '    # Secondary prompt
    export PS3='>> '   # Prompt 3
    export PS4='+> '   # Prompt 4

    # don't put duplicate lines in the history. See bash(1) for more options
    # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
    HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
    # ... or force ignoredups and ignorespace
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # make less more friendly for non-text input files, see lesspipe(1)
    [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        #alias dir='dir --color=auto'
        #alias vdir='vdir --color=auto'

        #alias grep='grep --color=auto'
        #alias fgrep='fgrep --color=auto'
        #alias egrep='egrep --color=auto'
    fi

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.
    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
        . /etc/bash_completion
    fi

    # Añade rake auto-completado:
    if [ -f ~/.scripts/rake_cap_bash_autocomplete.sh ]; then
        . ~/.scripts/rake_cap_bash_autocomplete.sh
    fi

    # Load RVM into a shell session *as a function*
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

    # Se establece Atom como editor por defecto:
    #export EDITOR="atom"

    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

    PATH=$PATH:$HOME/.composer/vendor/bin # Add Composer to PATH

    PATH=$PATH:$HOME/code/magento2/bin # Add Magento2 to PATH

    source "$HOME/.console/console.rc" 2>/dev/null

    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash

    if [[ $TERMINIX_ID ]]; then
        source /etc/profile.d/vte.sh
    fi

    alias drush8-enf='$HOME/code/enforex/vendor/bin/drush --uri=enforex $@'
    alias drush8-dq='$HOME/code/enforex/vendor/bin/drush --uri=donquijote $@'
    alias drush8='$HOME/code/enforex/vendor/bin/drush $@'
    alias drupal-enf='$HOME/code/enforex/vendor/bin/drupal --uri=enforex $@'
    alias drupal-dq='$HOME/code/enforex/vendor/bin/drupal --uri=donquijote $@'

    docker-drupal-enf () {
        (cd $HOME/code/enforex.docker/docker-compose; docker-compose exec fpm bash -c "cd web; ../vendor/bin/drupal --uri=enforex $*")
    }
    docker-drupal-dq () {
        (cd $HOME/code/enforex.docker/docker-compose; docker-compose exec fpm bash -c "cd web; ../vendor/bin/drupal --uri=donquijote $*")
    }
    docker-drupal-sp () {
        (cd $HOME/code/san-prosper.docker/docker-compose; docker-compose exec fpm bash -c "cd web; ../vendor/bin/drupal $*")
    }


    docker-drush-enf () {
        (cd $HOME/code/enforex.docker/docker-compose; docker-compose exec fpm bash -c "cd web; ../vendor/bin/drush --uri=enforex $*")
    }
    docker-drush-dq () {
        (cd $HOME/code/enforex.docker/docker-compose; docker-compose exec fpm bash -c "cd web; ../vendor/bin/drush --uri=donquijote $*")
    }
    docker-drush-sp () {
        (cd $HOME/code/san-prosper.docker/docker-compose; docker-compose exec fpm bash -c "cd web; ../vendor/bin/drush $*")
    }


    docker-mysql-enf () {
        mysql -h127.0.0.1 -uroot -prootdev -P3206 enforexdev;
    }
    docker-mysql-dq () {
        mysql -h127.0.0.1 -uroot -prootdev -P3206 dqdev;
    }

    docker-mysqlimport-enf () {
        mysql -h127.0.0.1 -uroot -prootdev -P3206 enforexdev < $@;
    }
    docker-mysqlimport-dq () {
        mysql -h127.0.0.1 -uroot -prootdev -P3206 dqdev < $@;
    }
    docker-mysqlimport-sp () {
        mysql -h127.0.0.1 -uroot -prootdev -P3206 drupalorexdev < $@;
    }


    docker-mysqldump-enf () {
        mysqldump -h127.0.0.1 -uroot -prootdev -P3206 enforexdev > $@;
    }
    docker-mysqldump-dq () {
        mysqldump -h127.0.0.1 -uroot -prootdev -P3206 dqdev > $@;
    }
    docker-mysqldump-sp () {
        mysqldump -h127.0.0.1 -uroot -prootdev -P3206 drupalorexdev > $@;
    }


    # Google Cloud SDK is a set of tools that you can use to manage resources and applications hosted on Google Cloud Platform.
    # These include the gcloud, gsutil, and bq command line tools.
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

    source <(kubectl completion bash)

fi
