(use-package corfu
  :straight (:files (:defaults "extensions/*.el"))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
:config
(keymap-set corfu-map "RET" `( menu-item "" nil :filter
                               ,(lambda (&optional _)
                                  (and (derived-mode-p 'eshell-mode 'comint-mode)
                                       #'corfu-send))))
(advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
(advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify))

(provide 'freemacs-corfu)
