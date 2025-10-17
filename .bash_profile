#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export GPG_TTY=$(tty)
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export OMNISHARPHOME="$XDG_CONFIG_HOME"/omnisharp

dbus-update-activation-environment --systemd --all

if uwsm check may-start
then
    exec uwsm start hyprland-uwsm.desktop
fi
