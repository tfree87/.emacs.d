;; Start Emacs Server

;; I have this option run only when I am not executing Emacs as a portable app as it is unlikely that there will be Emacs installed on the system that I am running Emacs on when I am using it as a portable application.

;; Start an Emacs server

(use-package server
  :straight (:type built-in)
  :if (not (freemacs/isportable-p))
  :config
  (unless (server-running-p)
    (server-start)))

;; End

;; Tell Emacs what feature this file provides.

(provide 'freemacs-server)
