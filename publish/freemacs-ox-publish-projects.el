(setq org-publish-project-alist
      '(("Emacs Configuration"
         :base-directory "~/.emacs.d/modules"
         :base-extension "org"
         :publishing-directory "~/.emacs.d/docs/"
         :recursive t
         :include ("~/.emacs.d/init.org" "~/.emacs.d/early-init.org" "~/.emacs.d/README.org")
         :publishing-function org-html-publish-to-html
         :auto-preamble t)))

(provide 'freemacs-ox-publish-projects)
