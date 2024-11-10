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

(use-package docker-tramp
  :straight t
  :defer t)

(use-package dockerfile-mode
  :straight t
  :mode ("Dockerfile\\'" . dockerfile-mode))

(provide 'freemacs-docker)

;;; freemacs-docker.el ends here
