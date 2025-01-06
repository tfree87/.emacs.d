;; -*- lexical-binding: t -*-

(use-package popper
  :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :custeom
  (popper-reference-buffers
          '("\\*Warnings\\*"
            "\\*Messages\\*"
            "\\*Embark Actions\\*"
            "Output\\*$"
            "\\*Async Shell Command\\*"
            "\\*Whicher Report\\*"
            help-mode
            compilation-mode))
  :config
  (popper-mode t)
  (popper-echo-mode t))


(require 'freemacs-popper)

;;; freemacs-popper.el ends here.
