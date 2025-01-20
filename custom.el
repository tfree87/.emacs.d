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
 '(variable-pitch ((t (:family "Liberation Serif")))))
