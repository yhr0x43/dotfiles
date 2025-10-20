# ~/.config/zsh/.zprofile
# ZDOTDIR is set to @{HOME}/.config/zsh in /etc/security/pam_env.conf
# see pam_env.conf(5) for more detail

[ -f ~/.config/zsh/.zshrc ] && . ~/.config/zsh/.zshrc

export GPG_TTY=$(tty)
# FIXME: absolute GNUPGHOME before systemd
# think of a solution to use the systemctl gpg-agent service
# which should be activated by a socket, and how SSH_AUTH_SOCK
# can be set after this activation
export GNUPGHOME=~/.local/share/gnupg
gpgconf --launch gpg-agent
gpg-connect-agent updatestartuptty /bye > /dev/null
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

dbus-update-activation-environment --systemd --all

if uwsm check may-start
then
    exec uwsm start hyprland-uwsm.desktop
fi
