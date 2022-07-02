(use-package powershell
  :straight t
  :if (eq system-type 'windows-nt)
  :defer t
  :init
  (whicher "powershell.exe")
  :config
  ;; Change default compile command for powershell
  (add-hook 'powershell-mode-hook
            (lambda ()
              (set (make-local-variable 'compile-command)
                   (format
                     "powershell.exe -NoLogo -NonInteractive -Command \"& '%s'\"")
                    (buffer-file-name)))))

(provide 'freemacs-powershell)
