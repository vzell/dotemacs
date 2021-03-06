;; https://github.com/jwiegley/use-package
;; https://github.com/raxod502/straight.el

;; Bootstrap code for "straight"
(setq straight-repository-branch "develop")
(setq straight-use-package-by-default t)

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

;; Effectively replace use-package with straight-use-package
;; https://github.com/raxod502/straight.el#integration-with-use-package
(straight-use-package 'use-package)

;; Generic customization
;; https://www.reddit.com/r/emacs/comments/js9r52/migrating_to_a_customfileless_setup/
(use-package emacs
  :straight (:type built-in)
  :custom
  (fill-column 80)
  )

(use-package paren
  :config
  (show-paren-mode t))

;; Face definitions
(defvar shell-output-from-buffer-face 'shell-output-from-buffer-face
  "Face name to use for 'Output from buffer...' message")

(defface shell-output-from-buffer-face '((t (:background  "orange")))
  "Face used for highlighting of 'Output from buffer...' messages."
  :group 'shell)

;; Font lock additions
(font-lock-add-keywords 'shell-mode
			'(
			  ("Output from buffer.*$" 0 shell-output-from-buffer-face)
			  ))

(use-package vz-custom-functions
  :straight (:repo "https://github.com/vzell/emacs-misc.git"
 		   :branch "master")
  :config
  (require 'rect)
  (require 'vz-custom-functions)
  (require 'vz-custom-menu))

(use-package which-key
  :config (which-key-mode)
  )

(use-package magit
  :bind ("C-x g" . magit-status)
  )

(use-package forge
  :after magit
  )

(use-package org
  :after vz-custom-functions
  :bind (:map org-mode-map
              ([f1] . vz-write-output-to-orgfile-as-src)
              ([f2] . vz-org-mark-line)
              ([f3] . vz-org-mark-cb)
              ([f4] . vz-org-send-region-to-other-window)
              ([f5] . vz-org-send-region-to-other-window2)
              ([f6] . vz-org-send-region-to-other-window3)
              ([f7] . vz-org-send-region-to-other-window4)
              ([f8] . vz-org-send-region-to-other-window5)
              ([f9] . vz-org-send-region-to-other-window6))
  :custom
  (org-adapt-indentation nil "Finally: do NOT indent body when indenting headlines")
  )

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  (setq yas-wrap-around-region t
	yas-indent-line nil)
  )

(use-package yasnippet-snippets
  )

;; https://emacs.stackexchange.com/questions/32862/ivy-disable-completion-for-a-command-in-minibuffer
;; C-M-j (ivy-immediate-done) - Exits with the current input instead of the current candidate
(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d "))

(use-package bash-completion
  :config (bash-completion-setup))

(use-package docker
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  )

(use-package docker-compose-mode
  )

(use-package kubernetes
  :bind ("C-c k" . kubernetes-overview))

(use-package kubernetes-tramp
  )

(setq tramp-default-method "ssh")

(setenv "PAGER" "/bin/cat")

(global-set-key "\C-co" 'occur)

;; Better functionality than using the standard commands
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default

;; (setq custom-file "~/.emacs.d/custom.el")
;; (load custom-file)

(server-start)
