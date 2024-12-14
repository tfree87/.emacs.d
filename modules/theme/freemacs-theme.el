;; Default Font

;; Create a function to check if a font exists on the system.

(defun font-available-p (font-name)
  (member font-name (font-family-list)))



;; Change the default font to use Hack if it is available.

(when (font-available-p "Hack")
  (custom-theme-set-faces
   'user
   '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 100 :width normal))))))

;; Fixed and Variable Pitch Fonts

;; To make Mixed Pitch mode  visually appealing, the fonts ~variable-pitch~ and ~fixed-pitch~ can be set. If Emacs is used on multiple operating systems, the fonts can be specified per operating system using a conditional ~cond~ statement. The code below will use different fonts for a Windows system versus a GNU/Linux system.


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

;; Mixed Pitch

;; Mixed pitch mode is a package that makes it easy to use a combination of fixed-width and variable-width fonts in the same buffer. I use this with Org Mode to use different file types for prose and and for source code blocks.

(use-package mixed-pitch
  :straight t
  :hook
  (org-mode . mixed-pitch-mode))

;; Nyan Mode

;; [[https://github.com/TeMPOraL/nyan-mode][Nyan-mode]] displays a nyan cat on the mode line that shows progress through a buffer.

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

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-theme)

;;; freemacs-theme.el ends here
