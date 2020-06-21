(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(defvar packages '(use-package))

(dolist (p packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

(show-paren-mode t)
(use-package smartparens
  :ensure t
  :config
  (sp-use-paredit-bindings)
  (add-hook 'prog-mode-hook #'smartparens-mode)
  (sp-pair "{" nil :post-handlers '(("||\n[i]" "RET"))))

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode))

(use-package org-bullets
      :ensure t
      :config
      (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package htmlize
        :ensure t)

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode)

(use-package evil
    :ensure t
    :init
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(ido-mode 1)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-file-extensions-order '(".org"))
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))
(setq ido-vertical-define-keys 'C-n-and-C-p-only)

(use-package smex
  :ensure t
  :init (smex-initialize)
  :bind
  ("M-x" . smex))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
(setq dashboard-banner-logo-title "Welcome to Emacs!")
(setq dashboard-startup-banner 'logo)
(setq dashboard-show-shortcuts nil)

(use-package elfeed
  :ensure t)

(load "~/.emacs.d/elfeed-feeds.el")

(setq user-full-name "Jan Wiśniewski"
      user-mail-address "cherrry9@disroot.org"
      calendar-location-name "Poland, Tczew")

(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

(blink-cursor-mode 0)

(global-display-line-numbers-mode t)
(setq display-line-numbers-type (quote relative))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(setq browse-url-browser-function 'eww-browse-url)

(setq kill-buffer-query-functions
  (remq 'process-kill-buffer-query-function
         kill-buffer-query-functions))

(setq-default indent-tabs-mode nil)
(setq tab-width 2)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t
      version-control t
      delete-old-versions t
      kept-new-versions 20
      kept-old-versions 5)

(defalias 'yes-or-no-p 'y-or-n-p)

(add-hook 'org-mode-hook 'auto-fill-mode)
(setq-default fill-column 80)

(defun comment-auto-fill ()
  (setq-local comment-auto-fill-only-comments t)
  (auto-fill-mode 1))

(add-hook 'prog-mode-hook 'comment-auto-fill)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(setq-default sentence-end-double-space nil)

(setq vc-follow-symlinks t)

(global-auto-revert-mode t)

(setq compilation-scroll-output t)

(global-hl-line-mode 1)

(defun reload-emacs-configuration()
  "Reload the configuration"
  (interactive)
    (load "~/.emacs.d/init.el"))

(defun open-emacs-configuration ()
  "Open the configuration.org file in buffer"
  (interactive)
    (find-file "~/.emacs.d/README.org"))

(global-set-key (kbd "C-c c r") 'reload-emacs-configuration)
(global-set-key (kbd "C-c c o") 'open-emacs-configuration)

(global-set-key (kbd "C-c f") 'find-file-at-point)

(global-set-key (kbd "C-c i") 'imenu)
