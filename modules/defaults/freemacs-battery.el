(use-package battery
  :straight (:type built-in)
  :defer 3
  :config
  (if (and battery-status-function
           (not (any '(lambda (value)
                        (string-match-p 
                         (battery-format "%B"
                                         (funcall battery-status-function))
                         value))
                     '("unknown" "N/A" "NA"))))
  (display-battery-mode t))
  )

;; End

;; Tell Emacs what package this file provides.


(provide 'freemacs-battery)

;;; freemacs-battery.el ends here.
