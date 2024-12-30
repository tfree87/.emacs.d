(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9d5124bef86c2348d7d4774ca384ae7b6027ff7f6eb3c401378e298ce605f83a" default))
 '(holiday-local-holidays
   '((holiday-sexp
      '(let
           ((date
             (calendar-nth-named-day 4 4 11 year)))
         (setf
          (nth 1 date)
          (1+
           (nth 1 date)))
         date)
      "Day after Thanksgiving")))
 '(org-safe-remote-resources
   '("\\`https://tfree87\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(safe-local-variable-values
   '((eval add-hook 'after-save-hook
           (lambda nil
             (org-babel-tangle))
           nil t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "outline" :slant normal :weight normal :height 100 :width normal))))
 '(fixed-pitch ((t (:family "Hack"))))
 '(fringe ((t (:background "#0c0a20"))))
 '(header-line ((t :box (:line-width 4 :color "#0a091c" :style nil))))
 '(header-line-highlight ((t :box (:color "#f2f3f7"))))
 '(keycast-key ((t)))
 '(line-number ((t :background "#0c0a20")))
 '(mode-line ((t :box (:line-width 6 :color "#0a091c" :style nil))))
 '(mode-line-active ((t :box (:line-width 6 :color "#0a091c" :style nil))))
 '(mode-line-highlight ((t :box (:color "#f2f3f7"))))
 '(mode-line-inactive ((t :box (:line-width 6 :color "#0c0a20" :style nil))))
 '(tab-bar-tab ((t :box (:line-width 4 :color "#0c0a20" :style nil))))
 '(tab-bar-tab-inactive ((t :box (:line-width 4 :color "#090819" :style nil))))
 '(tab-line-tab ((t)))
 '(tab-line-tab-active ((t)))
 '(tab-line-tab-current ((t)))
 '(tab-line-tab-inactive ((t)))
 '(variable-pitch ((t (:family "Liberation Serif"))))
 '(vertical-border ((t :background "#0c0a20" :foreground "#0c0a20")))
 '(window-divider ((t (:background "#0c0a20" :foreground "#0c0a20"))))
 '(window-divider-first-pixel ((t (:background "#0c0a20" :foreground "#0c0a20"))))
 '(window-divider-last-pixel ((t (:background "#0c0a20" :foreground "#0c0a20")))))
