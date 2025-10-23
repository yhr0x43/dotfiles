# ~/.config/zsh/.zprofile
# ZDOTDIR is set to @{HOME}/.config/zsh in /etc/security/pam_env.conf
# see pam_env.conf(5) for more detail

[ -f ~/.config/zsh/.zshrc ] && . ~/.config/zsh/.zshrc

if uwsm check may-start
then
    exec uwsm start hyprland-uwsm.desktop
fi
