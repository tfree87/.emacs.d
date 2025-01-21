;; freemacs-corfu

;; Corfu provides completion in region functions. This will create pop ups with completion options in the buffer.


(use-package corfu
  :straight (:files (:defaults "extensions/*.el"))
  :defer t
  :hook
  (meow-insert-enter . (lambda ()
                         (progn
                           (corfu-mode 1)
                           (corfu-popupinfo-mode 1))))
  (meow-insert-exit . (lambda ()
                        (progn
                          (corfu-quit)
                          (corfu-mode -1)
                          (corfu-popupinfo-mode -1))))
  :bind
  (:map corfu-map
	("<down>" . nil)
	("<up>" . nil)
	("TAB" . corfu-next)
	([tab] . corfu-next)
	("S-TAB" . corfu-previous)
	([backtab] . corfu-previous))
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  :config
  (keymap-set corfu-map "RET" `( menu-item "" nil :filter
  			       ,(lambda (&optional _)
  				  (and (derived-mode-p 'eshell-mode 'comint-mode)
  				       #'corfu-send))))
  (when (bound-and-true-p nerd-icons-corfu-mapping)
    (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter)))

  (provide 'freemacs-corfu)

;;; freemacs-corfu.el ends here.
