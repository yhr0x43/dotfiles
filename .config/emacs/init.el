;;;; init.el  -*- lexical-binding:t -*-
(setq debug-on-error t)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; here stores stand-alone elisp files
(add-to-list 'load-path (expand-file-name "local" user-emacs-directory))

;; separate custom.el file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; local/user.el contains device-local or private values
(load "user.el")

;; transparency
(set-frame-parameter nil 'alpha-background 80)
(add-to-list 'default-frame-alist '(alpha-background . 80))

(use-package emacs
  :bind (("<f5>" . compile)
         ("C-," . duplicate-line)
         ("C-." . copy-from-above-command)))

(use-package dired
  :bind (:map dired-mode-map
              ("r" . dired-kill-subdir)))

(use-package whitespace-mode
  :hook ((before-save . whitespace-cleanup)
         (c-mode . whitespace-mode)
         (emacs-lisp-mode . whitespace-mode)))

(use-package multiple-cursors
  :bind (("C-<return>" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)))

;; https://systemcrafters.net/emacs-mail/managing-multiple-accounts/
(use-package mu4e
  :config
  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-maildir "~/.local/mail")

  ;; Context specific variables are set in local/user.el
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name rc/gmail0-name
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p rc/gmail0-dir (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,rc/gmail0-email)
                  (user-full-name    . ,rc/gmail0-fullname)
                  (mu4e-drafts-folder . ,(concat rc/gmail0-dir "/Drafts"))
                  (mu4e-sent-folder   . ,(concat rc/gmail0-dir "/Sent Mail"))
                  (mu4e-refile-folder . ,(concat rc/gmail0-dir "/All Mail"))
                  (mu4e-trash-folder  . ,(concat rc/gmail0-dir "/Trash"))))
         (make-mu4e-context
          :name rc/yhrcl-name
          :match-func
          (lambda (msg)
            (when msg
              (string-prefix-p rc/yhrcl-dir (mu4e-message-field msg :maildir))))
          :vars `((user-mail-address . ,rc/yhrcl-email)
                  (user-full-name    . ,rc/yhrcl-fullname)
                  (mu4e-drafts-folder . "/Drafts")
                  (mu4e-sent-folder   . "/Sent")
                  (mu4e-refile-folder . "/Archive")
                  (mu4e-trash-folder  . "/Trash")))))
  (setq mu4e-maildir-shortcuts
        '(("/Inbox" . ?i))))

(use-package cc-mode
  :config
  (setq-default c-basic-offset 4
                c-default-style '((java-mode . "java")
                                  (awk-mode . "awk")
                                  (other . "gnu")))
  :hook (c-mode . (lambda ()
                    (display-fill-column-indicator-mode t)
                    (set-fill-column 80))))

;;(use-package powershell)

(use-package forth-mode
  :load-path (lambda () (when (eq system-type 'windows-nt) "c:/Program Files/gforth"))
  :init
  (load "gforth"))

;;(use-package rainbow-delimiters
;;  :hook emacs-lisp-mode)

(use-package web-mode
  :defer t
  :mode ("\\.html\\'" "\\.cshtml\\'" "\\.blade\\'" "\\.svelte\\'")
  :config
  (setq web-mode-engines-alist
        '(("razor"  . "\\.cshtml\\'")
          ("blade"  . "\\.blade\\.")
          ("svelte" . "\\.svelte\\."))))

(use-package conf-windows-mode
  :mode "\\.ini\\'")

;; melpa packages
(use-package sudo-edit
  :bind (("C-C C-r" . sudo-edit)))

;; load this after everything else per recommendation by envrc author
;; https://github.com/purcell/envrc#usage
(with-eval-after-load 'envrc
  (envrc-global-mode))

;; enabled rare commands
(put 'dired-find-alternate-file 'disabled nil)
(put 'downcase-region 'disabled nil)
