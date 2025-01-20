(use-package ispell
  :straight (:type built-in)
  :custom
  (ispell-local-dictionary "en_US")
  (ispell-program-name (whicher "hunspell"))
  (ispell-local-dictionary-alist '(("en_US"
                                    "[[:alpha:]]"
                                    "[^[:alpha:]]"
                                    "[']"
                                    nil
                                    ("-d" "en_US")
                                    nil
                                    utf-8)))
  :defer t
  :config
  (when (boundp 'ispell-hunspell-dictionary-alist)
    (setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist))
  (setq hunspell-default-dict "en_US"))

(use-package flyspell
  :straight (:type built-in)
  :defer t
  :init
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  (add-hook 'text-mode-hook 'flyspell-mode))

(provide 'freemacs-spellcheck)

;;; freemacs-spellcheck.el ends here
