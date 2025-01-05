;; -*- lexical-binding: t -*-

(use-package mixed-pitch
    :straight t
    :hook
    (org-mode . mixed-pitch-mode)
   :config
   (cond ((and (eq system-type 'windows-nt)
               (font-available-p "Times New Roman")
               (font-available-p "Hack"))
          (custom-theme-set-faces
           'user
           '(variable-pitch ((t (:family "Times New Roman"))))
           '(fixed-pitch ((t (:family "Hack"))))))
         ((and (eq system-type 'gnu/linux)
               (font-available-p "Liberation Serif")
               (font-available-p "Hack"))
          (custom-theme-set-faces
           'user
           '(variable-pitch ((t (:family "Liberation Serif"))))
           '(fixed-pitch ((t (:family "Hack"))))))))

  (provide 'freemacs-mp)

  ;;; freemacs-mp.el ends here.
