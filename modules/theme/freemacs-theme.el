(defun font-available-p (font-name)
  (member font-name (font-family-list)))

(when (font-available-p "Hack")
  (custom-theme-set-faces
   'user
   '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 100 :width normal))))))

(cond ((and (eq system-type 'windows-nt)
            (font-available-p "Times New Roman")
            (font-available-p "Hack"))
       (custom-theme-set-faces
        'user
        '(variable-pitch ((t (:family "Times New Roman"))))
        '(fixed-pitch ((t (:family "Hack"))))))
      ((and (eq system-type 'gnu/linux)
            (font-available-p "Liberation Serif")
            (font-available-p "Hack"))
      (custom-theme-set-faces
       'user
       '(variable-pitch ((t (:family "Liberation Serif"))))
       '(fixed-pitch ((t (:family "Hack")))))))

(custom-theme-set-faces
 'user
 '(sr-active-path-face ((t (:foreground "yellow" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:background "yellow" :foreground "dark violet" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:foreground "lightgray" :weight bold :height 120)))))

(use-package time
  :defer 3
  :custom
  (display-time-and-date t)
  :config
  (display-time-mode t))

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

(use-package tool-bar
  :straight (:type built-in)
  :config
  (tool-bar-mode -1))

(use-package scroll-bar
  :straight (:type built-in)
  :config
  (toggle-scroll-bar -1))

(use-package mixed-pitch
  :straight t
  :hook
  (org-mode . mixed-pitch-mode))

(use-package nyan-mode
  :straight t
  :if window-system
  :defer 3
  :init
  ;; Requires mplayer to play the music
  (whicher "mplayer")
  :custom
  (nyan-wavy-trail t)
  :config
  (nyan-mode)
  (nyan-start-animation))

(provide 'freemacs-theme)

;;; freemacs-theme.el ends here
