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

(use-package which-key
  :config (which-key-mode)
  )

(use-package magit
  :bind ("C-x g" . magit-status)
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
