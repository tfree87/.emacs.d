(use-package ispell
  :straight (:type built-in)
  :defer t
  :config
  (if (eq system-type 'windows-nt)
      (progn (setq ispell-program-name (expand-file-name "~/.emacs.d/hunspell/bin/hunspell.exe"))
             (setq ispell-personal-dictionary "~/.emacs.d/hunspell_en_US")
             (setq ispell-local-dictionary "en_US")
             (setq ispell-local-dictionary-alist
                   '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8))))
    (setq ispell-program-name (whicher "hunspell"))))

(use-package flyspell
  :straight (:type built-in)
  :defer t
  :init
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'text-mode-hook 'flyspell-mode))

(provide 'freemacs-spellcheck)

;;; freemacs-spellcheck.el ends here
