;; # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-

;; #+title: Async Module
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2024-11-29 10:17:22 thomas>
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

;; #+SETUPFILE: https://tfree87.github.io/org-html-themes/org/theme-readtheorg.setup
;; -----


;; The code below collects customizations for Emacs built-in components.

(use-package async
  :straight t
  :custom
  
  :config
  (autoload 'dired-async-mode "dired-async.el" nil t)
  (dired-async-mode 1))

(provide 'freemacs-async)

;;; freemacs-defaults.el ends here
