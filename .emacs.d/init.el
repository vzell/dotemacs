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
              ([f9] . vz-org-send-region-to-other-window6)
  ))

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
  :straight t
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
	ivy-count-format "%d/%d "))

(use-package bash-completion
  :straight t 
  :config (bash-completion-setup))

(use-package docker
  :straight t
  :bind ("C-c d" . docker))

(use-package dockerfile-mode
  :straight t)

(use-package docker-compose-mode
  :straight t)

(setq tramp-default-method "ssh")

(show-paren-mode t)

(setenv "PAGER" "/bin/cat")

(global-set-key "\C-co" 'occur)

;; Better functionality than using the standard commands
(defalias 'list-buffers 'ibuffer-other-window) ; make ibuffer default

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(server-start)
