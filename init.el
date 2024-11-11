;;; init.el --- Emacs initialization file -*- lexical-binding: t -*-

;; Copyright (C) 2022-2024 Thomas Freeman

;; Author: Thomas Freeman
;; Maintainer: Thomas Freeman
;; Keywords: lisp
;; Version: 0.0.1
;; Created: 09 Jan 2022

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

;; This file is an init file for Emacs.
;;
;; This file is NOT a part of Emacs.
;;
;; This file IS NOT intended to be edited! It was generated by init.org.

;;; URL: https://github.com/tfree87/.emacs.d

;; For documentation and for editing this file, see the init.org in the
;; github repository tfree87/.emacs.d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:

;; Performance Optimization Start
;; to slightly reduce the load time for Emacs, the whole ~init.el~ file can be wrapped in the following let statement. See [[https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/][this Reddit post]] for more information.

(let ((file-name-handler-alist nil))

;; Load Path
;; All of this Emacs configuration is in modules. The ~modules~ directory and all of its sub-directories must be added to the Emacs ~load-path~.

(let ((default-directory "~/.emacs.d/modules/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Check for Portable Emacs Instance
;; When [[file:runemacs.bat][runemacs.bat]] is executed, it will set the environment variable ~EMACS_PORTABLE~ to "Y". By checking for this, we can tell that Emacs that it was executed to be run from a flash drive.

(defun freemacs/isportable-p ()
  "A function to check whether Emacs was executed as a portable application in Windows by the runemacs.bat script."
  (string= (getenv "EMACS_PORTABLE") "Y"))

;; Set Location of Portable Git

;; Straight.el cannot operate without access to Git. Luckily, there is a portable version of Git ([[https://github.com/sheabunge/GitPortable][sheabunge/GitPortable]]) for Windows that can be installed on the [[https://portableapps.com/][PortableApp]] platform to provide access to Git without having it installed on the host system. After downloading GitPortable, we need to tell Emacs where it can find the binary executable so that Emacs programs can call Git when needed.

;; The following line code will check to see if Emacs is being run as a portable app and, if it is, then add the path where git.exe can be found to the ~exec-path~ list:


(when (freemacs/isportable-p)
  (add-to-list 'exec-path "~/PortableApps/GitPortable/App/Git/bin"))

;; Custom Set Variables
;; Place custom variables in [[./custom.el]] rather than [[./init.el]].

(setq custom-file "~/.emacs.d/custom.el")


;; Load the custom variables (Emacs customize interface) file.
;; This needs to be done early in the loading process because it contains the addresses for the package repositories.

(load custom-file)

;; Straight.el
;; Instead of the built-in package manager, use [[https://github.com/raxod502/straight.el][straight.el]] to pull all the packages straight from their repositories.

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
;; Use ~straight.el~ to install ~use-package~ to manage Emacs packages.

(straight-use-package 'use-package)

;; Benchmark Init
;; Use benchmark-init to check the time that it takes to load Emacs.

(require 'freemacs-benchmark-init)

;; No-littering
;; Load the [[./modules/startup/freemacs-no-littering.org][No Littering module]].

(require 'freemacs-no-littering)

;; Whicher
;; Load the [[./modules/startup/freemacs-whicher.org][Whicher module]].

(require 'freemacs-whicher)

;; Emacs Defaults
;; Changes to the default settings of Emacs from the  the [[file:modules/defaults/freemacs-defaults.org][defaults module]].

(require 'freemacs-defaults)

(require 'freemacs-listen)

(require 'freemacs-aggressive-indent)

;; Centered-Window Mode
;; Load the [[./modules/theme/freemacs-cwm.org][Centered Window module]].

(require 'freemacs-cwm)

;; Coding
;; Load the [[file:modules/coding/freemacs-coding.org][coding module]].

(require 'freemacs-project)

(require 'freemacs-coding)

(require 'freemacs-autohotkey)

;; Cape
;; Load the [[./modules/completion/freemacs-cape.org][Cape module]].

(require 'freemacs-cape)

;; Consult
;; Load the [[./modules/completion/freemacs-consult.org][Consult module]].

(require 'freemacs-consult)

;; Corfu
;; Load the [[./modules/completion/freemacs-corfu.org][Corfu module]]

(require 'freemacs-corfu)

;; Dired
;; Load the [[file:modules/file-tools/freemacs-dired.org][Dired module]].

(require 'freemacs-dired)

;; Dirvish
;; Load the [[./modules/file-tools/freemacs-dired.org][Dirvish Module]].

(require 'freemacs-dirvish)

;; Docker
;; Load the the [[file:modules/docker/freemacs-docker.org][docker module]].

(require 'freemacs-docker)

;; Eat
;; Load the [[./modules/shells/freemacs-eat.org][Eat Module]].

(require 'freemacs-eat)

;; Elfeed
;; Load the [[./modules/elfeed/freemacs-elfeed.org][Elfeed Module]].

(require 'freemacs-elfeed)

;  (require 'freemacs-elfeed-protocol)

;; Embark
;; Load the [[./modules/completion/freemacs-embark.org][Embark module]]

(require 'freemacs-embark)

;; Eshell
;; Load the [[./modules/shells/freemacs-eshell.org][Eshell Module]].

(require 'freemacs-eshell)

;; Gnus

;; Load the [[./modules/email/freemacs-gnus.org][Gnus Module]].

(require 'freemacs-gnus)

;; Help
;; The [[file:modules/help/freemacs-help.org][help module]] contains configuration that adds additional tools for help tools in Emacs:

(require 'freemacs-help)

;; Graphing
;; Load the [[file:modules/graphing/freemacs-graphing.org][graphing module]].

(require 'freemacs-graphing)

;; Ledger
;; Load the [[file:modules/math/freemacs-ledger.org][Ledger module]].

(require 'freemacs-ledger)

;; Marginalia
;; Loadt the [[./modules/completion/freemacs-marginalia.org][Marginalia module]].

(require 'freemacs-marginalia)

;; Markdown
;; Load the [[File:modules/publishing/freemacs-markdown.org][Markdown module]].

(require 'freemacs-markdown)

;; Meow Mode
;; Load the [[./modules/editing/freemacs-meow.org][Meow Mode module]].

(require 'freemacs-meow)

;; Nerd Icons
;; Load the [[./modules/theme/freemacs-nerd-icons.org][Nerd Icons module]].

(require 'freemacs-nerd-icons)

;; Orderless
;; Load the [[./modules/completion/freemacs-orderless.el][Orderless module]].

(require 'freemacs-orderless)

;; Org
;; Load the [[./modules/org/freemacs-org.org][Org Mode module]].

(require 'freemacs-org)

;; Org Contacts
;; Load the [[./modules/org/freemacs-org-contacts.org][Org Contacts Module]].

(require 'freemacs-org-contacts)

(require 'freemacs-org-mime)

;; Org Mind Map
;; Load the [[./modules/org/freemacs-org-mm.org][Org Mind Map module]]/

(require 'freemacs-org-mm)

;; Org-QL
;; Load the [[./modules/org/freemacs-org-ql.org][Org Ql Module]].

(require 'freemacs-org-ql)

(require 'freemacs-orgsl)

;; Ox-publish
;; ~ox-publish.el~ makes it easy to create multi-page websites from Org Mode files by defining a publishing project. The configuration for this package can be found in the [[file:modules/publishing/freemacs-ox-publish.org][ox-publish module]].

(require 'freemacs-ox-publish)

;; Session
;; Load the [[./modules/session/freemacs-session.org][Session Module]].

(require 'freemacs-session)

;; Trashed
;; Load the [[./modules/file-tools/freemacs-trashed.org][Trashed Module]].

(require 'freemacs-trashed)

;; Vertico
;; Load the [[file:modules/completion/freemacs-completion.org][completion module]]

(require 'freemacs-vertico)

;; VTerm
;; Load the [[./modules/shells/freemacs-vterm.org][Vterm Module]].

(require 'freemacs-vterm)

;; Theme style
;; Load the [[./modules/theme/freemacs-theme.org][Theme Module]].

(require 'freemacs-theme)

;; Academic Writing
;; The [[file:modules/publishing/freemacs-academic-writing.org][academic writing module]] contains configurations to improve the environment for writing academic papers in Emacs. It contains configuration for the following packages:
;; + Academic Phrases :: A package that inserts common template phrases into academic papers
;; + Citar :: A citation tool that simplifies adding citations to documents
;; + Org Cite :: The built-in Org Mode citation management system

(require 'freemacs-academic-writing)

;; Spellchecking
;; The spellchecking module configures the spell checking environment in Emacs. A few of the changes made:

;; + Flyspell is on be default so that you do not need to remember to call ~ispell~.
;; + Hunspell is used as the default spellchecking backend as it is more modern and works on multiple operating systems.


(require 'freemacs-spellcheck)

;; \LaTeX{}
;; Configuration for working with \LaTeX documents can be found in the [[file:modules/publishing/freemacs-latex.org][\LaTeX{} module]].


(require 'freemacs-latex)

;; PDF
;; To improve the speed and to extend the ability to view PDF files in Emacs, the [[file:modules/publishing/freemacs-pdf.org][PDF module]] can be loaded.

(require 'freemacs-pdf)

;; YASnippet
;; Load the [[./modules/editing/freemacs-yasnippet.org][YASnippet module]].

(require 'freemacs-yasnippet)

;; YouTube
;; Load the [[./modules/youtube/freemacs-youtube.org][YouTube Module]].

(require 'freemacs-youtube)

;; Emacs Server

;; Load the [[file:modules/server/freemacs-server.org][server module]].

(require 'freemacs-server)

;; Performance Optimization End
;; Close off the ~let~ statement at the beginning of the init file.

(setq gc-cons-threshold 800000)
)

;; End
;; Add a final comment to indicate the end of the file.

(provide 'init)

;;; init.el ends here
