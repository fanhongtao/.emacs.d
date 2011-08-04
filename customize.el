;; Customized configure

(tool-bar-mode nil)
(scroll-bar-mode nil)
(fset 'yes-or-no-p  'y-or-n-p)
(setq inhibit-startup-message t)
(setq column-number-mode 1)
(setq default-fill-column 120)
(setq default-major-mode 'text-mode)
(setq default-tab-width 4)
(setq kill-whole-line t)            ; Kill the whole line if cursor is at begin of line
(setq transient-mark-mode t)
(setq make-backup-files nil)
(setq track-eol t)

; (prefer-coding-system 'utf-8)

(global-set-key [M-left]    'windmove-left)
(global-set-key [M-right]   'windmove-right)
(global-set-key [M-up]      'windmove-up)
(global-set-key [M-down]    'windmove-down)


; Code completion
(global-set-key [(M-/)] 'hippie-expand)
(setq hippie-expand-try-functions-list 
  '(try-expand-dabbrev
    try-expand-dabbrev-visible
    try-expand-dabbrev-all-buffers
    try-expand-dabbrev-from-kill
    try-complete-file-name-partially
    try-complete-file-name
    try-expand-all-abbrevs
    try-expand-list
    try-expand-line
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol))

 
;==============================================================================
; Plugin: linum
;   http://web.student.tuwien.ac.at/~e0225855/linum/linum.html
(require 'linum)
(setq linum-format "%3d ")
(global-linum-mode 1)

;==============================================================================
; color-theme, use 'Dark Laptop'
(require 'color-theme)
(color-theme-initialize)
(color-theme-dark-laptop)

;==============================================================================
; CEDET
(load-file "~/.emacs.d/site-lisp/common/cedet-1.0/common/cedet.el")
(require 'semantic-ia)
(require 'semantic-gcc)
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-gaudy-code-helpers)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
(global-ede-mode t)
(global-srecode-minor-mode 1)
(global-set-key [f12] 'semantic-ia-fast-jump)

; Enable folding
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C-c z c") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c z o") 'semantic-tag-folding-show-block)

;==============================================================================
; Read project setting
(defun auto-load-ebe-project ()
    (setq ebe-proj-name ".emacsprj/project.ebe")
    (setq current-dir (expand-file-name "."))
    (setq last-dir nil)
    (while (not (string= last-dir  current-dir))
        ; (message "=============== [%s]" current-dir)
        (setq last-dir current-dir)
        (if (file-readable-p (expand-file-name ebe-proj-name  current-dir))
            (
                (load (expand-file-name ebe-proj-name  current-dir))
                ;(message ">>>>>>>>>>  file %s exist" ebe-proj-name)
            )
            (setq current-dir (directory-file-name (file-name-directory current-dir)))
        )
        ;(message "=============== l:[%s], c:[%s]" last-dir current-dir)
    )
)

(auto-load-ebe-project)

;==============================================================================
; ECB
(require 'ecb)
(setq ecb-tip-of-the-day nil)   ; Disable Tip of Day
(ecb-activate)
(ecb-toggle-ecb-windows)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

