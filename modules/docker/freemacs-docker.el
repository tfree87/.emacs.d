(use-package docker
  :straight t
  :commands docker
  :init
  (whicher "docker")
  :bind ("C-c d" . docker))

(use-package docker-compose-mode
  :straight t
  :mode "docker-compose\\.y\."
  :init
  (whicher "docker-compose"))

(use-package dockerfile-mode
  :straight t
  :mode ("Dockerfile\\'" . dockerfile-mode))

(provide 'freemacs-docker)

;;; freemacs-docker.el ends here
