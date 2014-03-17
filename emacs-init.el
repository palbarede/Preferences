;;; emacs.d/init.el
;;;
;;; - https://github.com/magnars/.emacs.d/blob/master/init.el
;;; - http://www.emacswiki.org/emacs/ImenuMode

;;; nasconde la toolbar; e' bene farlo all'inizio per evitare che venga mostrata brevemente
(if window-system 
	(tool-bar-mode -1))
;;; nasconde la scroll bar (perchè mai?)
; (scroll-bar-mode -1)
 
(defconst *is-a-mac* (eq system-type 'darwin))

(add-to-list 'load-path (expand-file-name "elisp-init" user-emacs-directory))

;;; emacs custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(require 'init-bindings)
(require 'init-config)
(require 'init-packages)
(require 'init-local-elisp)
(require 'init-requires)
(require 'init-themes)
(require 'init-org)
(require 'init-web)
(require 'init-modes)
(require 'init-python)
(require 'init-functions)
(require 'init-aliases)

