;; Mail Directory
;; Set the default mail directory

;(org-contacts-gnus-insinuate)
(setq nnml-directory "~/Mail")
(setq message-directory "~/Mail")

;; Change Reply Position
;; Put all replies at the top of the email since many people just want to read the most recent message and skip the whole email thread.

(setq message-cite-reply-position 'above)

;; IMAP Email Accounts
;; Set up IMAP email accounts in Gnus

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
                (nnmail-expiry-wait 'immediate))))

;; Show Gmail Folders
;; Make Gnus NOT ignore [Gmail] folders where Trash, Sent Mail and Draft are found

(setq  gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]")

;; Groups View
;; Place Gnus messages under headings listed by topic.

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(eval-after-load 'gnus-topic
  '(progn
     (setq gnus-message-archive-group '((format-time-string "sent.%Y")))
     (setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/Mail/archive")
                                (nnfolder-active-file "~/Mail/archive/active")
                                (nnfolder-get-new-mail nil)
                                (nnfolder-inhibit-expiry t))))

     (setq gnus-topic-topology '(("Gnus")
                                 (("Gmail" visible nil nil))
                                 (("Albion" visible nil nil))
                                 (("Misc" visible nil nil))))

     (setq gnus-topic-alist '(("Gmail"
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

;; Appearance of Summary Buffer
;; The code below will change the appearance of the summary buffer so that reading emails from the summary buffer is a little cleaner and easier to view the threads.

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
       "%3{│%}" "%1{%o%}" "%3{│%}"
       "  "
       "%4{%-20,20f%}"
       "  "
       "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
(setq gnus-summary-display-arrow t)

;; Change the group line format
(setq gnus-group-line-format "%M%S%5y:%B%(%G%)\n")

;; Three-pane Layout
;; Setting a three-pane layout will put the different folders on the left side, the summary buffer on top right, and the article view at the bottom left.

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
