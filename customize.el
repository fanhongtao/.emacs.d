;; Customized configure

;; color-theme, use 'Dark Laptop'
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)


;; CEDET
(load-file "~/.emacs.d/site-lisp/common/cedet-1.0/common/cedet.el")
(semantic-load-enable-excessive-code-helpers)
(global-ede-mode t)
(require 'semantic-ia)
(require 'semantic-gcc)
(global-srecode-minor-mode 1)


;; ECB
(require 'ecb)
(ecb-activate)


