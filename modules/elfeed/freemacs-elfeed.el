(use-package elfeed
  :straight t
  :defer t
  :commands elfeed
  :custom
  (setq elfeed-feeds
        '("https://www.sciencedaily.com/rss/all.xml")))

(use-package elfeed-tube
  :straight (elfeed-tube :host github
                         :repo "karthink/elfeed-tube"
                         :branch "master")
  :defer t
  :after elfeed
  :config
  (require 'elfeed-tube-mpv)
  (elfeed-tube-setup)
  (elfeed-tube-add-feeds '("https://www.youtube.com/c/inanutshell/"
                           "https://www.youtube.com/c/veritasium/")))

(use-package mpv
  :straight t
  :defer t)

(provide 'freemacs-elfeed)
