(use-package exwm
  :straight t
  :if
  (and (not (string= (substring (shell-command-to-string "wmctrl -m ; echo $?")
                            -2 -1) "0"))
   (eq window-system 'x))
  :custom
  (exwm-workspace-number 1)
  (exwm-input-global-keys
   `(([?\s-r] . exwm-reset)
     ([s-left] . windmove-left)
     ([s-right] . windmove-right)
     ([s-up] . windmove-up)
     ([s-down] . windmove-down)
     ([?\s-w] . exwm-workspace-switch)
     ([?\s-&] . (lambda (command)
                  (interactive (list (read-shell-command "$ ")))
                  (start-process-shell-command command nil command)))))
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
  (require 'exwm-randr)
  (exwm-randr-enable)
  (require 'exwm-systemtray)
  (exwm-systemtray-enable)
  ,@(mapcar (lambda (i)
              `(,(kbd (format "s-%d" i)) .
                (lambda ()
                  (interactive)
                  (exwm-workspace-switch-create ,i))))
            (number-sequence 0 9))
  
  (define-key exwm-mode-map [?\C-q] 'exwm-input-send-next-key)
  (add-hook 'exwm-update-class-hook (lambda()
                                      (exwm-workspace-rename-buffer
                                       exwm-class-name)))
  (shell-command
   (concat
    (whicher "xinput")
    " set-prop \"SynPS/2 Synaptics TouchPad\""
    " \"libinput Tapping Enabled\" 1"))    
  (exwm-enable)
  (display-battery-mode t)
  (when (executable-find "nm-applet")
    (start-process-shell-command "nm-applet" nil "nm-applet")))

(use-package desktop-environment
  :straight t
  :init
  (mapc #'whicher '("brightnessctl"
                   "amixer"
                   "scrot"
                   "slock"
                   "upower"
                   "TLP"
                   "playerctl"))
  :after exwm
  :config (desktop-environment-mode))
