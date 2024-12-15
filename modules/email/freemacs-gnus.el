(use-package gnus
  :straight (:type built-in)
  :defer t
  :hook
  (dired-mode . turn-on-gnus-dired-mode)
  :custom
  (gnus-init-file "~/.emacs.d/gnus.el")
  (gnus-icalendar-org-capture-file (concat (car org-agenda-files) "/inbox.org"))
  (gnus-icalendar-org-capture-headline '("Calendar"))
  :config
  (require 'gnus-icalendar)
  (gnus-icalendar-setup)
  (gnus-icalendar-org-setup)
   )

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-gnus)

;;; freemacs-gnus.el ends here.
