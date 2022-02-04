(setq nnml-directory "~/Mail")
(setq message-directory "~/Mail")

(setq message-cite-reply-position 'above)

(setq gnus-select-method '(nnnil nil))
(setq gnus-secondary-select-methods
      '((nnimap "gmail"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash")
                (nnmail-expiry-wait 'immediate))
        (nnimap "albion"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnmail-expiry-target "nnimap+albion:[Gmail]/Trash")
                (nnmail-expiry-wait 'immediate))
        (nnimap "work"
                (nnimap-address "outlook.office365.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnmail-expiry-target "nnimap+work:Deleted Items")
                (nnmail-expiry-wait 'immediate))))

(setq  gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

(load-file "gnus-styles.el")

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(eval-after-load 'gnus-topic
  '(progn
     (setq gnus-message-archive-group '((format-time-string "sent.%Y")))
     (setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/mail/archive")
                                (nnfolder-active-file "~/mail/archive/active")
                                (nnfolder-get-new-mail nil)
                                (nnfolder-inhibit-expiry t))))

     (setq gnus-topic-topology '(("Gnus" visible)
                                 (("Misc" visible))
                                 (("Work" visible nil nil))
                                 (("Gmail" visible nil nil))
                                 (("Albion" visible nil nil))))

     (setq gnus-topic-alist '(("Work"
                               "nnimap+work:INBOX"
                               "nnimap+work:Sent Items"
                               "nnimap+work:Drafts"
                               "nnimap+work:Junk Email"
                               "nnimap+work:Deleted Items")
                              ("Gmail"
                               "nnimap+gmail:INBOX"
                               "nnimap+gmail:[Gmail]/Sent Mail"
                               "nnimap+gmail:[Gmail]/Drafts"
                               "nnimap+gmail:[Gmail]/Spam"
                               "nnimap+gmail:[Gmail]/Trash")
                              ("Albion"
                               "nnimap+albion:INBOX"
                               "nnimap+albion:[Gmail]/Sent Mail"
                               "nnimap+albion:[Gmail]/Drafts"
                               "nnimap+albion:[Gmail]/Spam"
                               "nnimap+albion:[Gmail]/Trash")
                              ("Misc"
                               "nndraft:drafts")
                              ("Gnus")))))

;; The following lines will display threads in a clearer way with UTF-8 text showing message replies
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  (setq gnus-sum-thread-tree-root "● ")
  (setq gnus-sum-thread-tree-false-root "◯ ")
  (setq gnus-sum-thread-tree-single-indent "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))

;; The following lines change how emails are listed in the summary buffer
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"
       "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"               ;; name
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)

;; Change the group line format
(setq gnus-group-line-format "%M%S%5y:%B%(%G%)\n")

;; Three-pane layout for gnus
(gnus-add-configuration
 '(article
   (horizontal 1.0
               (vertical 35
                         (group 1.0))
               (vertical 1.0
                         (summary 0.25 point)
                         (article 1.0)))))
(gnus-add-configuration
 '(summary
   (horizontal 1.0
               (vertical 35
                         (group 1.0))
               (vertical 1.0
                         (summary 1.0 point)))))
