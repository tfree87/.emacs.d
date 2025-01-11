;; Default Font

;; Change the default font to use Hack if it is available.


(when (font-available-p "Hack")
  (custom-theme-set-faces
   'user
   '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 100 :width normal))))))

(use-package doom-themes
  :straight t
  :if window-system
  :defer 1
  :config
  (load-theme 'doom-outrun-electric t)
  (doom-themes-org-config))

(use-package doom-modeline
  :straight t
  :if window-system
  :defer 1
  :config (doom-modeline-mode))

(use-package menu-bar
  :straight (:type built-in)
  :config
  (menu-bar-mode -1))



;; Hide the tool bar.

(use-package tool-bar
  :straight (:type built-in)
  :config
  (tool-bar-mode -1))



;; Hide the scroll bar.

(use-package scroll-bar
  :straight (:type built-in)
  :config
  (toggle-scroll-bar -1))

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-theme)

;;; freemacs-theme.el ends here
