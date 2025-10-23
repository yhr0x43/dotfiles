[Unit]
Description=GnuPG cryptographic agent and passphrase cache
Documentation=man:gpg-agent(1)

[Socket]
# gpgconf --list-dirs agent-socket
ListenStream=%t/gnupg`'GPGSOCKETSUBDIR`'/S.gpg-agent
FileDescriptorName=std
SocketMode=0600
DirectoryMode=0700
