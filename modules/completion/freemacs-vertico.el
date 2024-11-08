;; Vertico

;; [[https://github.com/minad/vertico][Vertico]] removes the ~*Completions*~ buffer and instead, populates a vertical list of completion options in the minibuffer region.

(use-package vertico
  :straight t
  :demand t
  :bind
  (:map vertico-map
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous)
        ("C-f" . vertico-exit)
        :map minibuffer-local-map
        ("M-b" . backward-kill-word))
  :custom
  (vertico-cycle t)
  (vertico-resize t)
  :init
  (vertico-mode))

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-vertico)
