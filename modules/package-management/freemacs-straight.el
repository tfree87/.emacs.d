;; # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-
 
;; #+title:  Straight Module
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2024-12-31 17:37:49 thomas>
;; #+description: This org-mode file contains an org-babel implementation of the .emacs or .emacs.d/init.el file.
;; #+language: en_US
;; #+property: header-args :results silent :exports code

;; #+options: html-link-use-abs-url:nil html-postamble:auto
;; #+options: html-preamble:t html-scripts:nil html-style:t
;; #+options: html5-fancy:nil tex:t num:nil 
;; #+html_doctype: xhtml-strict
;; #+html_container: div
;; #+html_content_class: content
;; #+keywords: Emacs
;; #+html_link_home: index.html
;; #+html_link_up: index.html

;; #+SETUPFILE: https://tfree87.github.io/org-html-themes/org/theme-readtheorg.setup
;; -----

;; Use [[https://github.com/raxod502/straight.el][straight.el]] to pull all the packages repositories directly.

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(provide 'freemacs-straight)

;;; freemacs-straight.el ends here.
