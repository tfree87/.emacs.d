;; Install Corfu

;; Corfu provides completion in region functions. This will create pop ups with completion options in the buffer.

;; [[file:freemacs-corfu.org::*Install Corfu][Install Corfu:1]]
(use-package corfu
  :straight (:files (:defaults "extensions/*.el"))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode)
  :defer t
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
  :config
  (keymap-set corfu-map "RET" `( menu-item "" nil :filter
                                 ,(lambda (&optional _)
                                    (and (derived-mode-p 'eshell-mode 'comint-mode)
                                         #'corfu-send)))))
;; Install Corfu:1 ends here

(provide 'freemacs-corfu)
