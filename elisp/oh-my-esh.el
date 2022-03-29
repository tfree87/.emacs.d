;;; oh-my-esh.el --- Extensions for Emacs Eshell -*- lexical-binding: t; -*-

;; Copyright (C) 2022 Thomas Freeman

;; Author: Thomas Freeman
;; Keywords: lisp
;; Version: 0.0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Extensions for Emacs Eshell

;;; Code:

(defun oh-my-esh/add-sudo ()
  "Takes the previous command entered into the eshell and appends sudo in front of it."
  (insert (concat "sudo " (format "%s" (eshell-get-history 1)))))

(defun sudo-find-file (file)
  "Open FILE as root."
  (interactive "FOpen file as root: ")
  (when (file-writable-p file)
    (user-error "File is user writeable, aborting sudo"))
  (find-file (if (file-remote-p file)
                 (concat "/" (file-remote-p file 'method) ":"
                         (file-remote-p file 'user) "@" (file-remote-p file 'host)
                         "|sudo:root@"
                         (file-remote-p file 'host) ":" (file-remote-p file 'localname))
               (concat "/sudo:root@localhost:" file))))

(defun oh-my-esh/rsync ()
  "Adds aliases for commonly-used rsync commands."
  (eshell/alias "rsync-copy" "rsync -avz --progress -h")
  (eshell/alias "rsync-move" "rsync -avz --progress -h --remove-source-files")
  (eshell/alias "rsync-update" "rsync -avzu --progress -h")
  (exhell/alias "rsync-synchronize" "rsync -avzu --delete --progress -h"))

;;; oh-my-esh.el ends here
