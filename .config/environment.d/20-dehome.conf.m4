# ~/.config/environment.d/20-dehome.conf
# Reson for not setting these in ~/.config/uwsm/env is var expansion
# Not setting these in shell profile because in the desktop environemnt
# a shell can't be expected (e.g. browser, file manager, Emacs)

GNUPGHOME=${XDG_DATA_HOME}/gnupg
SSH_AUTH_SOCK=${XDG_RUNTIME_DIR}/gnupg`'GPGSOCKETSUBDIR`'/S.gpg-agent.ssh

DOTNET_CLI_HOME=${XDG_DATA_HOME}/dotnet
NUGET_PACKAGES=${XDG_CACHE_HOME}/NuGetPackages
OMNISHARPHOME=${XDG_CONFIG_HOME}/omnisharp

PASSWORD_STORE_DIR=${XDG_DATA_HOME}/password-store
