(setq inhibit-startup-message t)
(setf initial-buffer-choice "~/Documents/org/Life-OS.org")

(scroll-bar-mode -1)
(set-fringe-mode 10)

(blink-cursor-mode 0)

(setq scroll-conservatively 101)

(setq show-paren-delay 0)
(show-paren-mode 1)

(global-prettify-symbols-mode 1)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(use-package esup
  :pin melpa
  :commands (esup))

(use-package solaire-mode
  :hook (after-init . solaire-global-mode))
  ;;:config (setq solaire-mode-auto-swap-bg nil))

(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-flatwhite t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 130)

(use-package evil
  :init (setq evil-want-keybinding nil)
  :config (evil-mode 1))
  (define-key evil-normal-state-map (kbd "C-h") #'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-j") #'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-k") #'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-l") #'evil-window-right)

(use-package evil-collection
  :after evil
  :config (evil-collection-init))

(use-package evil-leader
  :after evil
  :config
  (global-evil-leader-mode 1)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "r" 'counsel-recentf)
  (evil-leader/set-key "e" 'eval-last-sexp)
  (evil-leader/set-key "oti" 'org-toggle-inline-images)
  (evil-leader/set-key "oth" 'org-toggle-heading)
  (evil-leader/set-key "ol" 'org-store-link)
  (evil-leader/set-key "oa" 'org-agenda)
  (evil-leader/set-key "oh" 'org-insert-heading-after-current)
  (evil-leader/set-key "od" 'org-insert-drawer)
  (evil-leader/set-key "os" 'org-sort)
  (evil-leader/set-key "orf" 'org-roam-find-file)
  (evil-leader/set-key "ori" 'org-roam-insert))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook (lambda () (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package treemacs
  :config (setq treemacs-width 25))

(use-package ivy
  :config (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :config (ivy-rich-mode 1))

(use-package all-the-icons-ivy-rich
  :after ivy
  :init (all-the-icons-ivy-rich-mode 1))

(use-package counsel
  :after ivy
  :config (counsel-mode 1))

(use-package which-key
  :config (which-key-mode 1))

(use-package company
  :config(add-hook 'after-init-hook 'global-company-mode))

(use-package company-emoji
  :init (add-to-list 'company-backends 'company-emoji))

(defun trigger-org-company-complete ()
  "Begins company-complete in org-mode buffer after pressing #+ chars."
  (interactive)
  (if (string-equal "#" (string (preceding-char)))
    (progn
      (insert "+")
      (company-complete))
    (insert "+")))

(eval-after-load 'org '(define-key org-mode-map
               (kbd "+") 'trigger-org-company-complete))

(use-package doom-modeline
  :init (doom-modeline-mode 1))

(use-package pdf-tools
  :config 
  (setq-default pdf-view-display-size 'fit-page)
  (setq pdf-view-use-scaling t)

  (custom-set-variables
    '(pdf-tools-handle-upgrades nil))
  (setq pdf-info-epdfinfo-program "/usr/local/bin/epdfinfo")
  (pdf-tools-install))

(use-package org
 :config
  (add-hook 'org-cycle-hook 'org-cycle-hide-drawers)
  (setq org-display-inline-images t)
  (setq org-redisplay-inline-images t)
  (setq org-startup-with-inline-images "inlineimages")
  (setq org-image-actual-width nil)
  (setq org-hide-emphasis-markers t)
  (setq org-directory "~/Documents/org")
  (setq org-default-notes-file "~/Documents/org/inbox.org")
  (setq org-agenda-files '("~/Documents/org"))
  (set-face-attribute 'org-level-1 nil :height 1.0)
  (set-face-attribute 'org-level-2 nil :inherit '(font-lock-constant-face))
  ;;(set-face-attribute 'org-todo nil :inherit '(font-lock-string-face))
  (setq org-fontify-whole-heading-line t))

(use-package olivetti
  :config (add-hook 'text-mode-hook 'turn-on-olivetti-mode))

(use-package backline
  :after outline
  :config (advice-add 'outline-flag-region :after 'backline-update))

(use-package org-download
  :config (add-hook 'dired-mode-hook 'org-download-enable))

(use-package org-roam
  :hook (after-init . org-roam-mode)
  :custom (org-roam-directory "~/Documents/org/roam"))

(use-package hydra)
(use-package org-fc
  :straight
  (org-fc
   :type git :repo "https://git.sr.ht/~l3kn/org-fc"
   :files (:defaults "awk" "demo.org"))
  :custom
  (org-fc-directories '("~/Documents/org/"))
  :config
  (require 'org-fc-hydra))

(evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-flip-mode
  (kbd "RET") 'org-fc-review-flip
  (kbd "n") 'org-fc-review-flip
  (kbd "s") 'org-fc-review-suspend-card
  (kbd "q") 'org-fc-review-quit)

(evil-define-minor-mode-key '(normal insert emacs) 'org-fc-review-rate-mode
  (kbd "a") 'org-fc-review-rate-again
  (kbd "h") 'org-fc-review-rate-hard
  (kbd "g") 'org-fc-review-rate-good
  (kbd "e") 'org-fc-review-rate-easy
  (kbd "s") 'org-fc-review-suspend-card
  (kbd "q") 'org-fc-review-quit)

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-bullets-bullet-list '("\u200b" "●" "○"  "○")))

(defun org-cycle-hide-drawers (state)
  "Re-hide all drawers after a visibility state change."
  (when (and (derived-mode-p 'org-mode)
             (not (memq state '(overview folded contents))))
    (save-excursion
      (let* ((globalp (memq state '(contents all)))
             (beg (if globalp
                    (point-min)
                    (point)))
             (end (if globalp
                    (point-max)
                    (if (eq state 'children)
                      (save-excursion
                        (outline-next-heading)
                        (point))
                      (org-end-of-subtree t)))))
        (goto-char beg)
        (while (re-search-forward org-drawer-regexp end t)
          (save-excursion
            (beginning-of-line 1)
            (when (looking-at org-drawer-regexp)
              (let* ((start (1- (match-beginning 0)))
                     (limit
                       (save-excursion
                         (outline-next-heading)
                           (point)))
                     (msg (format
                            (concat
                              "org-cycle-hide-drawers:  "
                              "`:END:`"
                              " line missing at position %s")
                            (1+ start))))
                (if (re-search-forward "^[ \t]*:END:" limit t)
                  (outline-flag-region start (point-at-eol) t)
                  (user-error msg))))))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(straight org-fc zen-mode which-key use-package treemacs spacemacs-theme solaire-mode pdf-tools org-roam org-drill org-download org-bullets olivetti mood-line modus-operandi-theme kaolin-themes evil-org evil-leader evil-goggles evil-collection esup emojify doom-themes doom-modeline counsel-spotify counsel company-emoji centaur-tabs backline ayu-theme all-the-icons-ivy-rich))
 '(pdf-tools-handle-upgrades nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
