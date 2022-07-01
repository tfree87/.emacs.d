;; Email Configuration

(setq mail-user-agent 'mu4e-user-agent)

(setq read-mail-command 'mu4e)

(use-package gnus
  :straight (:type built-in)
  :defer t
  :hook
  (dired-mode . turn-on-gnus-dired-mode)
  :custom
  (gnus-icalendar-org-capture-file "~/Dropbox/gtd/inbox.org")
  (gnus-icalendar-org-capture-headline '("Calendar"))
  :config
  (require 'gnus-icalendar)
  (gnus-icalendar-setup)
  (gnus-icalendar-org-setup))

(use-package mu4e
  :defer t
  :custom
  (mu4e-maildir (expand-file-name "~/Mail"))
  (mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a")
  (mu4e-view-prefer-html t)
  (mu4e-view-show-images t)
  ;; Update every 5 minutes
  (mu4e-update-interval 300)
  (mu4e-headers-auto-update t)
  (mu4e-compose-signature-auto-include t)
  (mu4e-compose-format-flowed t)
  (mu4e-compose-in-new-frame t)
  (mu4e-sent-messages-behavior 'delete)
  (mu4e-attachment-dir  "~/Downloads")
  (mu4e-change-filenames-when-moving t)
  (message-kill-buffer-on-exit t)
  (mu4e-compose-dont-reply-to-self t)
  :config
  (require 'mu4e-icalendar)
  (mu4e-icalendar-setup)
  (setq mu4e-org-contacts-file  "~/Dropbox/contacts.org")
   (add-to-list 'mu4e-headers-actions
     '("org-contact-add" . mu4e-action-add-org-contact) t)
   (add-to-list 'mu4e-view-actions
     '("org-contact-add" . mu4e-action-add-org-contact) t)
  (load "~/.emacs.d/mu4e/mu4e-contexts.el")
  (require 'mu4e-speedbar)
  ;; Add option to view emails in browser
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t))

(use-package org-mime
  :straight t
  :commands (org-mime-htmlize
             org-mime-org-buffer-htmlize
             org-mime-org-subtree-htmlize))

(provide 'freemacs-email)

;; freemacs-email.el ends here
