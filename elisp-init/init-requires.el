;;; various required packages

;; ido
(require 'ido)
(require 'flx-ido)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-everywhere t)
(ido-mode +1)
;;; Non-nil means that `ido' will do flexible string matching.
;;; Flexible matching means that if the entered string does not
;;; match any item, any item containing the entered characters
;;; in the given sequence will match.
; (setq ido-enable-flex-matching t)
;;; To use ido for all buffer and file selections in Emacs, customize the
;;; variable `ido-everywhere'.
; (setq ido-everywhere t)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;;; windmove
;;; per switchare finestra con shift+arrows o alt+arrows
(require 'windmove)
(windmove-default-keybindings 'meta)

;;; yasnippet
;; (require 'yasnippet)
;; O si abilita il global-mode, o il minor mode con degli hook per il major-mode
;; del linguaggio visualizzato; nel secondo caso pero' bisogna chiamare manualmente
;; (yas-reload-all)!
;;; (yas-global-mode 1
;;; (yas-reload-all)

;;; smex, remember recently and most frequently used commands
(require 'smex)
;; (setq smex-save-file (expand-file-name ".smex-items" prelude-savefile-dir))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; editor di regexp che evita la pazzia dei backslash
;; (require 're-builder)
;; evita la pazzia dei backslash
;; (setq reb-re-syntax 'string)

;; git
(require 'magit)
;; questi due sarebbero dipendenze, ma funziona tutto anche senza...
;(require 'git-commit-mode)
;(require 'git-rebase-mode)

;; dired bindings (tipo C-x C-j)
(require 'dired-x)

; zone e' fondamentale direi (per avere zone-when-idle)
;; (require 'zone)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;; move-text
;; (require 'move-text)
;; i binding di default sono alt+up e alt+down, gli stessi che uso
;; per switchare finestra.
;; (move-text-default-bindings)


;; evil-mode
(setq evil-want-C-u-scroll t)
(require 'evil)

(setq evil-emacs-state-cursor  '("red" box))
(setq evil-normal-state-cursor '("gray" box))
(setq evil-visual-state-cursor '("gray" box))
(setq evil-insert-state-cursor '("gray" bar))
(setq evil-motion-state-cursor '("gray" box))

(provide 'init-requires)
