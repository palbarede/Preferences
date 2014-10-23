
;; emacs.d/init.el
;;
;; - https://github.com/magnars/.emacs.d/blob/master/init.el
;; - http://www.emacswiki.org/emacs/ImenuMode

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules.

;;; Code:
;; nasconde la toolbar; e' bene farlo all'inizio per evitare che venga mostrata brevemente
(when (fboundp 'tool-bar-mode)
	(tool-bar-mode -1))
;; nasconde la scroll bar (perchè mai?)
; (scroll-bar-mode -1)
;; nasconde menubar
;; (menu-bar-mode -1)
 
(defconst *is-a-mac* (eq system-type 'darwin))

(defvar moo-preferences-dir (expand-file-name "~/Preferences/elisp-init")
  "The directory containing moo elisp files.")


;; (add-to-list 'load-path
;;              (expand-file-name "elisp-init" user-emacs-directory))
(add-to-list 'load-path moo-preferences-dir)

(require 'init-packages)
(require 'init-functions)
(require 'init-bindings)
(require 'init-config)
(require 'init-extra-elisp)
(require 'init-requires)
(require 'init-themes)
(require 'init-org)
(require 'init-web)
(require 'init-modes)
(require 'init-python)
(require 'init-aliases)
(when *is-a-mac*
  (require 'init-osx))

(let ((moo-local-config
       (concat (file-name-as-directory moo-preferences-dir) "init-local.el")))
  (load moo-local-config 'noerror))

;;; emacs custom settings
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)
