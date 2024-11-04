;; Install Centered Window Mode

;; Toggle on centered window mode when using a large screen with only a single Emacs window.


;; [[file:freemacs-cwm.org::*Install Centered Window Mode][Install Centered Window Mode:1]]
(use-package centered-window
  :straight t
  :custom
  (cwm-incremental-padding t)
  (cwm-incremental-padding-% 10)
  (cwm-centered-window-width 1000))
;; Install Centered Window Mode:1 ends here

(provide 'freemacs-cwm)
