;; Install AHK Mode

;; Install AHK Mode with Straight.


;; [[file:freemacs-autohotkey.org::*Install AHK Mode][Install AHK Mode:1]]
(use-package ahk-mode
  :straight t
  :defer t 
  :mode "\\.ahk\\'"
  :custom
  (ahk-identation 2))
;; Install AHK Mode:1 ends here

(provide 'freemacs-autohotkey)

;;; freemacs-autohotkey.el ends here
