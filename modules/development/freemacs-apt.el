(require 'transient)

(defun apt--args-to-string (arglist)
  "Take a list of arguments ARGLIST and return them as a string separated by
space."
  (mapconcat #'identity arglist " "))

(defun apt-remove (package)
  "Remove PACKAGE using apt."
  (interactive "sPackage to remove: ")
  (async-shell-command (concat "sudo apt remove -y " package)))

(defun apt-upgrade ()
  "Upgrade package lists using apt."
  (interactive)
  (async-shell-command "sudo apt upgrade -y"))

(defun apt-full-upgrade ()
  "Full upgrade package lists using apt."
  (interactive)
  (async-shell-command "sudo apt full-upgrade -y"))

(defun apt-update ()
  "Update package lists using apt."
  (interactive)
  (async-shell-command "sudo apt update"))

(defun apt-install (package &optional args)
  "Install a package with "
  (interactive "sPackage to install: ")
  (let ((arguments (transient-args transient-current-command)))
    (async-shell-command (concat "sudo apt install -y "
                                 package
                                 " " (apt--args-to-string arguments)))))

(transient-define-prefix apt-install-transient ()
  "Transient menu for apt install command"
  ["APT Package Manager"
   ["Arguments"
    ("-n" "no recommends" "--no-install-recommends")
    ("-r" "reinstall" "--reinstall")]
   ["Run"
    ("r" "Install" apt-install)]])

;;;###autoload (autoload 'apt "apt" nil t)
(transient-define-prefix apt ()
  "Transient menu for apt package manager."
  ["APT Package Manager"
   ["Basic Commands"
    ("i" "Install" apt-install-transient)
    ("r" "Remove" apt-remove)
    ("u" "Update" apt-update)
    ("U" "Upgrade" apt-upgrade)
    ("f" "Full Upgrade" apt-full-upgrade)]])

(provide 'freemacs-apt)
