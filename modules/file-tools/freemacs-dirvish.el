(use-package dirvish
  :straight t
  :init
  (dirvish-override-dired-mode)
  :custom
  (dirvish-hide-details nil)
  :config
  
  (setq dired-listing-switches
        "-l --almost-all --human-readable --group-directories-first --no-group")
  (dirvish-peek-mode)
  (dirvish-side-follow-mode)
  :bind
  (("C-c f" . dirvish-fd)
     :map dirvish-mode-map ; Dirvish inherits `dired-mode-map'
     ("a"   . dirvish-quick-access)
     ("f"   . dirvish-file-info-menu)
     ("y"   . dirvish-yank-menu)
     ("N"   . dirvish-narrow)
     ("^"   . dirvish-history-last)
     ("h"   . dirvish-history-jump) ; remapped `describe-mode'
     ("s"   . dirvish-quicksort)    ; remapped `dired-sort-toggle-or-edit'
     ("v"   . dirvish-vc-menu)      ; remapped `dired-view-file'
     ("TAB" . dirvish-subtree-toggle)
     ("M-f" . dirvish-history-go-forward)
     ("M-b" . dirvish-history-go-backward)
     ("M-l" . dirvish-ls-switches-menu)
     ("M-m" . dirvish-mark-menu)
     ("M-t" . dirvish-layout-toggle)
     ("M-s" . dirvish-setup-menu)
     ("M-e" . dirvish-emerge-menu)
     ("M-j" . dirvish-fd-jump)))

(provide 'freemacs-dirvish)
