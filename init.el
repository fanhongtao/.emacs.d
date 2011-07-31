;;{{{ packages, load-path and related
(add-to-list 'load-path "~/.emacs.d/lisp/")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(when (file-exists-p "~/.emacs.d/site-lisp/site-start.el")
  (load "~/.emacs.d/site-lisp/site-start.el"))


;; leave customization & os/distro/installation-specific settings to another file
;; (customizations, paths, theme)
(setq custom-file "~/.emacs.d/customize.el")
(if (file-exists-p custom-file)
    (load custom-file))

;;}}}



