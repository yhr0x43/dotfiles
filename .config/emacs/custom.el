;;;; custom.el  -*- lexical-binding:t -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-by-copying t)
 '(backup-directory-alist `(("." . "~/.local/share/emacs/backup")))
 '(column-number-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(delete-old-versions t)
 '(dired-guess-shell-alist-user
   '((".*"
      (when (executable-find "app2unit-open-service")
        "app2unit-open-service -- "))))
 '(display-line-numbers 'relative)
 '(font-latex-fontify-script nil)
 '(image-dired-marking-shows-next nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(kept-new-versions 6)
 '(kept-old-versions 2)
 '(menu-bar-mode nil)
 '(mu4e-get-mail-command "mbsync -a")
 '(mu4e-update-interval 300)
 '(package-selected-packages
   '(## arduino-mode json-mode magit multiple-cursors rainbow-delimiters
        sudo-edit web-mode))
 '(send-mail-function 'smtpmail-send-it)
 '(smtpmail-smtp-server "yhrcl.org")
 '(smtpmail-smtp-service 465)
 '(smtpmail-smtp-user "yhrc")
 '(smtpmail-stream-type 'tls)
 '(tab-width 8)
 '(tool-bar-mode nil)
 '(version-control t)
 '(whitespace-style
   '(face trailing tabs spaces newline missing-newline-at-eof empty
          indentation space-after-tab space-before-tab space-mark
          tab-mark newline-mark)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120)))))
