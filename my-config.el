;; Hook up all the major and minor modes we care about
(require 'emacs-modes)

;; Explorer more popular emacs options here: http://www.emacswiki.org/emacs/PopularOptions

;; Make it look good
(require 'theme)

;; Useful?
(require 'dircolors)

;;set cursor colour
(set-cursor-color "yellow")

;;make sure ansi color character escapes are honored
(ansi-color-for-comint-mode-on)

;;Highlighting the selected line
(defface hl-line '((t (:background "gray10")))
  "Face to use for `hl-line-face'." :group 'hl-line)
(setq hl-line-face 'hl-line)
(global-hl-line-mode t) ; turn it on for all modes by default

;;Allow font sizes to scale without distorting window dimensions
(require 'face-remap+)
(global-set-key (kbd "C-<") 'text-scale-decrease)
(global-set-key (kbd "C->") 'text-scale-increase)

(when (boundp 'mouse-wheel-down-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-down-event))
		  'text-scale-increase))

(when (boundp 'mouse-wheel-up-event) ; Emacs 22+
  (global-set-key (vector (list 'control mouse-wheel-up-event))
		  'text-scale-decrease))

;; Calms the default jumpy behavior
(require 'smooth-scrolling)

;; Display the current row and column number at the bottom of the window
(line-number-mode 1)
(column-number-mode 1)

;; Hide the hideous Emacs splash screen	 
(setq inhibit-splash-screen t)						

;; http://www.emacswiki.org/emacs/SavePlace
(require 'saveplace)
(setq-default save-place t)


;; Useful?
(setq read-file-name-completion-ignore-case nil)

(setq make-backup-files nil)            ;; More here http://www.emacswiki.org/emacs/BackupDirectory
(setq use-file-dialog nil)

;; Be a bit more Windows-friendly
(transient-mark-mode t) 		;; highlight text selection
(delete-selection-mode t) 		;; delete seleted text when typing
(cua-mode t) 				;; windows style keybind C-x, C-v, cut paste
(setq cua-auto-tabify-rectangles nil) 	;; Don't tabify after rectangle commands
(setq cua-keep-region-after-copy t) 	;; Selection remains after C-c
(transient-mark-mode 1)             	;; No region when it is not highlighted
(global-set-key "\C-a" 'mark-whole-buffer)	;; Select All
(global-set-key "\C-f" 'isearch-forward)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key "\C-w" 'kill-this-buffer)

;; Visual Studio 
(show-paren-mode t) ; light-up matching parens
(global-font-lock-mode t) ; turn on syntax highlight
(global-set-key [C-f4] (lambda () (interactive) (kill-buffer nil)))

;; Setup auto highlight symbol
(require 'auto-highlight-symbol-config)
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)

(add-hook 'after-init-hook 'my-after-init-hook)
(defun my-after-init-hook ()
  (require 'edts-start))

;; Set up buffer switching
(require 'cycle-buffer)
(global-set-key [C-S-tab] 'cycle-buffer-backward)
(global-set-key [C-tab] 'cycle-buffer)

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

;; ido provides a very nice auto-complete for finding files (type C-x f)
;; Learn more here: http://www.emacswiki.org/emacs/InteractivelyDoThings
(require 'ido)
(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10)


(setq text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))

;; Get rid of clutter
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))


(defun find-file-save-default-directory ()
  (interactive)
  (setq saved-default-directory default-directory)
  (ido-find-file)
  (setq default-directory saved-default-directory))
(global-set-key "\C-x\C-f" 'find-file-save-default-directory)

(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

(require 'sr-speedbar)
(setq speedbar-show-unknown-files t)
(setq speedbar-frame-parameters
	  `(
		(minibuffer)
		(width 25)
		(border-width 0)
		(menu-bar-lines 0)
		(tool-bar-lines 0)
;;		(unsplittable t)
		(left-fringe 0)))

(defun speedbar-open-and-select ()
  (interactive)
  (sr-speedbar-open)
  (sr-speedbar-select-window))

(global-set-key (kbd "C-o") 'speedbar-open-and-select)

(global-linum-mode t)

(provide 'my-config)

