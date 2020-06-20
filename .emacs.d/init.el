;; ui settings
(scroll-bar-mode 0)
(tool-bar-mode 0)
(menu-bar-mode 0)

;; disable cursor blinking
(blink-cursor-mode nil)

;; line numbers
(global-display-line-numbers-mode t)
(setq display-line-numbers-type (quote relative))

;; identation
(setq tab-width 2
      indent-tabs-mode nil)

;; splash screen
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; disable backups
(setq make-backup-files nil)

;; short yes / no to y / n
(defalias 'yes-or-no-p 'y-or-n-p)

;; interactively do things 
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

;; auto close bracket insertion
(electric-pair-mode 1)
;; match parenthesses
(show-paren-mode t)
;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

;; packages
(load "package")
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
