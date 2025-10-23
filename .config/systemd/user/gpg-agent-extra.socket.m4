[Unit]
Description=GnuPG cryptographic agent and passphrase cache (restricted)
Documentation=man:gpg-agent(1)

[Socket]
# gpgconf --list-dirs agent-extra-socket
ListenStream=%t/gnupg`'GPGSOCKETSUBDIR`'/S.gpg-agent.extra
FileDescriptorName=extra
Service=gpg-agent.service
SocketMode=0600
DirectoryMode=0700
