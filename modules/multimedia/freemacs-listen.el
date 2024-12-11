;; Install Listen.el


;; [[file:freemacs-listen.org::*Install Listen.el][Install Listen.el:1]]
(use-package listen
  :straight t
  :defer t
  :commands listen
  :custom
  (listen-directory "~/Music/"))
;; Install Listen.el:1 ends here

(provide 'freemacs-listen)
