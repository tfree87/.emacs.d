;; #+options: ':nil *:t -:t ::t <:t H:3 \n:nil ^:t arch:headline
;; #+options: author:t broken-links:nil c:nil creator:nil
;; #+options: d:(not "LOGBOOK") date:t e:t email:nil f:t inline:t num:t
;; #+options: p:nil pri:nil prop:nil stat:t tags:t tasks:t tex:t
;; #+options: timestamp:t title:t toc:t todo:t |:t
;; #+title:Elfeed Protocol Configuration
;; #+date: <2024-11-02 Sat>
;; #+author: Thomas
;; #+email: thomas@pidesktop
;; #+language: en
;; #+select_tags: export
;; #+exclude_tags: noexport
;; #+creator: Emacs 28.2 (Org mode 9.5.5)
;; #+cite_export:



(use-package elfeed-protocol
  :straight t
  :after elfeed
  :custom
  (elfeed-use-curl t)
  (elfeed-log-level 'debug)
  (elfeed-protocol-enabled-protocols '(fever))
  (elfeed-protocol-fever-update-unread-only t)
  (elfeed-protocol-fever-fetch-category-as-tag t)
  (elfeed-protocol-feeds '(("fever+https://thomas@freshrss.freemanpi.duckdns.org"
                                 :api-url "https://freshrss.freemanpi.duckdns.org/api/fever.php"
                                 :use-authinfo t)))
  :config
  (elfeed-protocol-enable))

(provide 'freemacs-elfeed-protocol)

;;; freemacs-elfeed-protocol.el ends here.
