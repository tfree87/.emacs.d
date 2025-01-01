;; # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-

;; #+title: Defaults Configuration
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2025-01-01 15:15:32 thomas>
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

(use-package emacs
  :custom
  (inhibit-startup-screen t)
  (apropos-sort-by-scores t)
  (bidi-paragraph-direction 'left-to-right)
  (version-control t)
  (delete-old-versions t)
  (vc-make-backup-files t)
  (register-preview-delay 0)
  (ring-bell-function #'ignore)
  (visible-bell t)
  (delete-by-moving-to-trash t)
  (column-number-mode t)
  (sentence-end-double-space nil)
  :config
  (windmove-default-keybindings)
  (add-hook 'before-save-hook 'time-stamp)
  (if (version<= "27.1" emacs-version)
      (setq bidi-inhibit-bpa t))
  (setq-default indent-tabs-mode nil)
  (fset 'yes-or-no-p 'y-or-n-p))

;; Default Fill Column

;; Set the default fill column to 80 to ensure code lines fit in most terminals.


(setq-default fill-column 80)

(use-package ibuffer
  :straight (:type built-in)
  :bind
  ("C-x C-b" . ibuffer))

(provide 'freemacs-defaults)

;;; freemacs-defaults.el ends here
