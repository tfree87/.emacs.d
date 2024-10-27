;; Install Calfw

;; [[https://github.com/kiwanami/emacs-calfw][Calfw]] provides a grid-based calendar view similar to what is seen in most graphical calendar programs but integrates the org agenda files. I use the fork from @zemaye as this version has fixed the issue in ~calfw-org.el~ where events that span multiple dates show up repeated on the display.


;; [[file:freemacs-calfw.org::*Install Calfw][Install Calfw:1]]
(use-package calfw
  :straight (emacs-calfw :host github
                         :repo "zemaye/emacs-calfw"
                         :branch "master")
  :commands (cfw:open-calendar-buffer)
  :init
  (defalias 'calfw 'cfw:open-calendar-buffer)
  :custom
  (cfw:fchar-junction ?╋)
  (cfw:fchar-vertical-line ?┃)
  (cfw:fchar-horizontal-line ?━)
  (cfw:fchar-left-junction ?┣)
  (cfw:fchar-right-junction ?┫)
  (cfw:fchar-top-junction ?┯)
  (cfw:fchar-top-left-corner ?┏)
  (cfw:fchar-top-right-corner ?┓))
;; Install Calfw:1 ends here

;; Calfw Org

;; ~calfw-org.el~  displays org-mode events in the ~calfw~ calendar. I don't like the long command ~M-x cfw:open-org-calendar~ so I have shortened to it to ~M-x calfworg~ which is much easier to type and remember.


;; [[file:freemacs-calfw.org::*Calfw Org][Calfw Org:1]]
(use-package calfw-org
  :straight (emacs-calfw :host github
                         :repo "zemaye/emacs-calfw"
                         :branch "master")
  :commands (cfw:open-org-calendar)
  :init
  (defalias 'calfworg 'cfw:open-org-calendar))
;; Calfw Org:1 ends here

(provide 'freemacs-calfw)

;;; freemacs-calfw.el ends here.
