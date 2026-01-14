# ~/.config/zsh/.zprofile
# ZDOTDIR is set to @{HOME}/.config/zsh in /etc/security/pam_env.conf
# see pam_env.conf(5) for more detail

# Don't get trapped by uwsm when in distrobox
[ -n "${DISTROBOX_ENTER_PATH}" ] && \
command -v uwsm && uwsm check may-start && \
    exec uwsm start hyprland-uwsm.desktop
