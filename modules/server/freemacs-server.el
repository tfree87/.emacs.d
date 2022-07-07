;; Start an Emacs server

(use-package server
  :straight (:type built-in)
  :if (not (freemacs/isportable-p))
  :config
  (unless (server-running-p)
    (server-start)))

(provide 'freemacs-server)
