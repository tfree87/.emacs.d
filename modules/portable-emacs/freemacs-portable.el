(defun freemacs/isportable-p ()
  "A function to check whether Emacs was executed as a portable application in
  Windows by the runemacs.bat script."
  (string= (getenv "EMACS_PORTABLE") "Y"))

(when (freemacs/isportable-p)
  (add-to-list 'exec-path "~/PortableApps/GitPortable/App/Git/bin"))

(provide 'freemacs-portable)

;;; freemacs-portable.el ends here.
