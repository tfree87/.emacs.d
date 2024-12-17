;; # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-

;; #+title: Org Super Agenda Module
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2024-12-16 20:07:27 thomas>
;; #+language: en_US
;; #+property: header-args :results silent :exports code

;; #+options: html-link-use-abs-url:nil html-postamble:auto
;; #+options: html-preamble:t html-scripts:nil html-style:t
;; #+options: html5-fancy:nil tex:t num:nil toc:t
;; #+html_doctype: xhtml-strict
;; #+html_container: div
;; #+html_content_class: content
;; #+keywords: Emacs
;; #+html_link_home: ../../index.html
;; #+html_link_up: ../../init.html
;; #+creator: <a href="https://www.gnu.org/software/emacs/">Emacs</a> 27.1 (<a href="https://orgmode.org">Org</a> mode 9.5.2)
;; #+html_head: <style>#org-div-home-and-up { text-align: right; padding-right: 10pt; }</style>

;; -----



(use-package 'org-super-agenda
  :straight t
  :after org
  :defer t
  :init
  (setq org-agenda-custom-commands
        '(("s" "Super Agenda"
           ((agenda "" ((org-super-agenda-groups 
                         '((:log t)
                           (:name "Schedule"
                                  :time-grid t)
                           (:name "Today"
                                  :scheduled today)
                           (:habit t)
                           (:name "Due today"
                                  :deadline today)
                           (:name "Overdue"
                                  :deadline past)
                           (:name "Due soon"
                                  :deadline future)
                           (:name "Unimportant"
                                  :todo ("SOMEDAY" "MAYBE" "TO-READ")
                                  :order 100)
                           (:name "Waiting..."
                                  :todo "WAITING"
                                  :order 98)
                           (:name "Scheduled earlier"
                                  :scheduled past)))))
            (todo "" ((org-agenda-overriding-header "Projects")
                      (org-super-agenda-groups
                       '((:name none
                                :children todo)
                         (:discard (:anything t)))))))))))

(setq org-agenda-custom-commands
      '(("s" "Super Agenda"
         ((agenda "" ((org-super-agenda-groups 
                       '((:log t)
                         (:name "Schedule"
                                :time-grid t)
                         (:name "Today"
                                :scheduled today)
                         (:habit t)
                         (:name "Due today"
                                :deadline today)
                         (:name "Overdue"
                                :deadline past)
                         (:name "Due soon"
                                :deadline future)
                         (:name "Unimportant"
                                :todo ("SOMEDAY" "MAYBE" "TO-READ")
                                :order 100)
                         (:name "Waiting..."
                                :todo "WAITING"
                                :order 98)
                         (:name "Scheduled earlier"
                                :scheduled past)))))
          (todo "" ((org-agenda-overriding-header "Projects")
                    (org-super-agenda-groups
                     '((:name none
                              :children todo)
                       (:discard (:anything t))))))))))

(provide 'freemacs-orgsa)

;;; freemacs-orgsa.el ends here.
