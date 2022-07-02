(use-package eaf
  :straight (eaf :type git
                 :host github
                 :repo "emacs-eaf/emacs-application-framework"           
                 :files ("*.el" "*.py" "core" "app" "*.json"))
  :config
  (require 'eaf-pdf-viewer)
  (require 'eaf-browser)
  (require 'eaf-image-viewer)
  (require 'eaf-terminal)
  (require 'eaf-video-player)
  (require 'eaf-markdown-previewer)
  (require 'eaf-org-previewer)
  (require 'eaf-music-player)
  (require 'eaf-file-manager)
  (require 'eaf-rss-reader)
  ;;(require 'eaf-mindmap)
  (require 'eaf-jupyter)
  (require 'eaf-camera)
  (require 'eaf-system-monitor)
  ;;(require 'eaf-netease-cloud-music)
  ;;(require 'eaf-file-browser)
  ;;(require 'eaf-file-sender)
  ;;(require 'eaf-airshare)
  ;;(require 'eaf-demo)
  ;;(require 'eaf-vue-demo)
  )

(provide 'freemacs-eaf)
