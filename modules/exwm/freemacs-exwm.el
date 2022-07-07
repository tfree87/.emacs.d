(use-package app-launcher
  :straight '(app-launcher :host github
                           :repo "tfree87/app-launcher"
                           :branch "symlink")
  :commands (app-launcher-run-app))

(use-package exwm
  :if
  (and (window-system)
       (not
        (string=
         (substring
          (shell-command-to-string
           (whicher "wmctrl -m ; echo $status"))
          -2 -1) "0")))
  :custom
  (exwm-workspace-number 1)
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([s-left] . windmove-left)
     ([s-right] . windmove-right)
     ([s-up] . windmove-up)
     ([s-down] . windmove-down)
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-e] . app-launcher-run-app)))
  (exwm-input-prefix-keys
   '(?\C-x
     ?\C-u
     ?\C-h
     ?\M-x
     ?\M-`
     ?\M-&
     ?\M-:
     ?\C-\M-j
     ?\C-\ ))
  :config
  (add-hook
   'exwm-update-class-hook (lambda()
                             (exwm-workspace-rename-buffer
                              exwm-class-name)))
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (require 'exwm-randr)
  (exwm-randr-enable)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  (whicher "nm-applet")
  (when (executable-find "nm-applet")
    (start-process-shell-command "nm-applet" nil "nm-applet"))
  (whicher "pasystray")
  (when (executable-find "pasystray")
    (start-process-shell-command "pasystray" nil "pasystray"))
  (whicher "xsettingsd")
  (when (executable-find "xsettingsd")
    (start-process-shell-command "xsettingsd" nil "xsettingsd"))
  (exwm-init))

(use-package desktop-environment
  :straight nil
  :after exwm
  :init
  (mapc #'whicher '("amixer"
                    "brightnessctl"
                    "numlockx"
                    "scrot"
                    "slock"
                    "upower"
                    "TLP"
                    "playerctl"))
  :config
  (desktop-environment-mode)
  (shell-command "pulseaudio --kill ; pulseaudio --start")
  (shell-command "numlockx on")
  (shell-command "xinput set-prop \"SynPS/2 Synaptics TouchPad\" \"libinput Tapping Enabled\" 1")
  (when (executable-find "flameshot")
    (start-process-shell-command "flameshot" nil "flameshot")))

(provide 'freemacs-exwm)

;;; freemacs-exwm.el ends here
