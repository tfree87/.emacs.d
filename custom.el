(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(bbdb-mua-interactive-action '(query . create) nil nil "Customized with use-package bbdb")
 '(column-number-mode t)
 '(custom-safe-themes
   '("da53441eb1a2a6c50217ee685a850c259e9974a8fa60e899d393040b4b8cc922" "da186cce19b5aed3f6a2316845583dbee76aea9255ea0da857d1c058ff003546" "0d01e1e300fcafa34ba35d5cf0a21b3b23bc4053d388e352ae6a901994597ab1" default))
 '(desktop-environment-volume-get-command "amixer -c 1 get Master")
 '(desktop-environment-volume-set-command "amixer -c 1 set Master %s")
 '(desktop-environment-volume-toggle-command "amixer -c 1 set Master toggle")
 '(display-time-mode t)
 '(exwm-systemtray-height 17)
 '(menu-bar-mode nil)
 '(org-modules
   '(ol-bbdb ol-bibtex ol-docview ol-doi ol-eww ol-gnus org-habit ol-info ol-irc ol-mhe ol-rmail ol-w3m))
 '(safe-local-variable-values
   '((org-use-tag-inheritance)
     (eval add-hook 'after-save-hook
           (lambda nil
             (org-babel-tangle))
           nil t)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "outline" :slant normal :weight normal :height 100 :width normal))))
 '(cfw:face-grid ((t (:foreground "magenta"))))
 '(fixed-pitch ((t (:family "Source Code Pro"))))
 '(sr-active-path-face ((t (:foreground "yellow" :weight bold :height 120))))
 '(sr-highlight-path-face ((t (:background "yellow" :foreground "dark violet" :weight bold :height 120))))
 '(sr-passive-path-face ((t (:foreground "lightgray" :weight bold :height 120))))
 '(variable-pitch ((t (:height 140 :family "Gentium Book Basic")))))

