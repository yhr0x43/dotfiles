[Unit]
Description=GnuPG network certificate management daemon
Documentation=man:dirmngr(8)

[Socket]
# gpgconf --list-dirs dirmngr-socket
ListenStream=%t/gnupg`'GPGSOCKETSUBDIR`'/S.dirmngr
SocketMode=0600
DirectoryMode=0700
