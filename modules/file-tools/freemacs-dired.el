;; # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-

;; #+title:Dired Configuration
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2024-12-30 17:42:30 thomas>
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


;; The following customizations make emacs dired mode behave in a similar fashion to other file browsing tools such as midnight commander. While there are many great file management tools out there. I keep coming back to emacs dired because of the keyboard commands and flexibility.

(use-package dired
  :straight (:type built-in)
  :defer t
  :custom
  (with-eval-after-load 'dired
    (require 'dired-x))
  (dired-dwim-target t))

;; Enable Dired-x


(with-eval-after-load 'dired
  (require 'dired-x))

(use-package wdired-mode
  :straight (:type built-in)
  :defer t
  :custom
  (wdired-allow-to-change-permissions t))

(use-package dired-collapse
  :straight t
  :after dired
  :hook
  (dired-mode . dired-collapse-mode))

(use-package dired-open
  :straight t
  :after dired
  :init
  (whicher "xdg-open")
  :config
  (define-key dired-mode-map (kbd "o") #'dired-open-xdg))

(use-package disk-usage
  :straight t
  :defer t)

(use-package async
  :straight t
  :defer t
  :init
  (autoload 'dired-async-mode "dired-async.el" nil t)
  :hook
  (dired . dired-async-mode))

(use-package rclone-tools
  :straight (rclone-tools :host github
                          :repo "tfree87/emacs-rclone-tools"
                          :branch "main")
  :defer t
  :init (whicher "rclone"))

(defun rclone-sync (source dest &optional rclone-path rclone-config)
  "Sync DEST with SOURCE using rclone.
The path to the rlcone executable can be set with RCLONE-PATH.
The rclone configuration can be set with RCLONE-CONFIG."
  (interactive)
  (let ((rclone-path (or rclone-path "rclone"))
        (rclone-config (or rclone-config nil))
        (config-option
         (if rclone-config
             (concat " --config " rclone-config)
           (nil))))
    (eshell-command
     (concat rclone-path
             config-option
             " -vP sync "
             source
             " "
             dest))))

(provide 'freemacs-dired)

;;; freemacs-dired.el ends here
