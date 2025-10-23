[Unit]
Description=GnuPG public key management service

[Socket]
# gpgconf --list-dirs keyboxd-socket
ListenStream=%t/gnupg`'GPGSOCKETSUBDIR`'/S.keyboxd
FileDescriptorName=std
SocketMode=0600
DirectoryMode=0700
