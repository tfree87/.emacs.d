(use-package docker
  :straight t
  :init
  (whicher "docker")
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :straight t
  :defer t
  :init
  (whicher "docker-compose"))

(provide 'freemacs-docker)

;;; freemacs-docker.el ends here
