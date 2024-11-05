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

;; In order to slightly reduce the load time for Emacs, the whole ~init.el~ file can be wrapped in the following let statement to speed up the load process. This can help a little when Emacs is run as a portable app from a flash drive as I often do.See [[https://www.reddit.com/r/emacs/comments/3kqt6e/2_easy_little_known_steps_to_speed_up_emacs_start/][this Reddit post]] for more information.


;; [[file:init.org::*Performance Optimization Start][Performance Optimization Start:1]]
(let ((file-name-handler-alist nil))
;; Performance Optimization Start:1 ends here

;; Load Path

;; Since all of the Emacs configuration is in modules, the ~modules~ directory and all of its sub-directories must be added to the Emacs ~load-path~.


;; [[file:init.org::*Load Path][Load Path:1]]
(let ((default-directory "~/.emacs.d/modules/"))
  (normal-top-level-add-subdirs-to-load-path))
;; Load Path:1 ends here

;; Check for Portable Emacs Instance

;; When [[file:runemacs.bat][runemacs.bat]] is executed, it will set the environment variable ~EMACS_PORTABLE~ to "Y". By checking for this, we can tell that Emacs that it was executed to be run from a flash drive.


;; [[file:init.org::*Check for Portable Emacs Instance][Check for Portable Emacs Instance:1]]
(defun freemacs/isportable-p ()
  "A function to check whether Emacs was executed as a portable application in Windows by the runemacs.bat script."
  (string= (getenv "EMACS_PORTABLE") "Y"))
;; Check for Portable Emacs Instance:1 ends here

;; Set Location of Portable Git

;; Straight.el cannot operate without access to Git. Luckily, there is a portable version of Git ([[https://github.com/sheabunge/GitPortable][sheabunge/GitPortable]]) for Windows that can be installed on the [[https://portableapps.com/][PortableApp]] platform to provide access to Git without having it installed on the host system. After downloading GitPortable, we need to tell Emacs where it can find the binary executable so that Emacs programs can call Git when needed.

;; The following line code will check to see if Emacs is being run as a portable app and, if it is, then add the path where git.exe can be found to the ~exec-path~ list:


;; [[file:init.org::*Set Location of Portable Git][Set Location of Portable Git:1]]
(when (freemacs/isportable-p)
  (add-to-list 'exec-path "~/PortableApps/GitPortable/App/Git/bin"))
;; Set Location of Portable Git:1 ends here

;; Custom Set Variables

;;  To keep variables set by the customize interfacei from being placed at the top of ~init.el~, Set Emacs customize to be put into a separate file [[./custom.el]].


;; [[file:init.org::*Custom Set Variables][Custom Set Variables:1]]
(setq custom-file "~/.emacs.d/custom.el")
;; Custom Set Variables:1 ends here



;; Load the custom file. This needs to be done early in the loading process because it contains the addresses for the package repositories. If this is not loaded before refreshing packages and making calls to ~use-package~, then the ~:ensure~ command will not be able to pull the packages and install them.


;; [[file:init.org::*Custom Set Variables][Custom Set Variables:2]]
(load custom-file)
;; Custom Set Variables:2 ends here

;; Straight.el

;; Instead of the built-in package manager, use [[https://github.com/raxod502/straight.el][straight.el]] to pull all the packages straight from their repositories.

;; 1. It is easier to avoid conflicts with different package repositories such as duplicates packages in ELPA and MELPA.
;; 2. I can define a specific fork to use for a specific package to get bug fixes or modifications.
;; 3. The entire package repository is cloned, which, while it takes up a lot of space, allows for editing the source code directly if desired.
;; 4. Github repositories that are not included in ELPA, MELPA, or marmalade can be pulled 
;;  used in ~use-package~ statements.


;; [[file:init.org::*Straight.el][Straight.el:1]]
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
;; Straight.el:1 ends here

;; Install use-package

;; Use ~straight.el~ to install ~use-package~ to manage Emacs packages.


;; [[file:init.org::*Install use-package][Install use-package:1]]
(straight-use-package 'use-package)
;; Install use-package:1 ends here

;; Benchmark Init

;; Use benchmark-init to check the time that it takes to load Emacs.


;; [[file:init.org::*Benchmark Init][Benchmark Init:1]]
(require 'freemacs-benchmark-init)
;; Benchmark Init:1 ends here

;; No-littering

;; Load the [[./modules/startup/freemacs-no-littering.org][No Littering module]].


;; [[file:init.org::*No-littering][No-littering:1]]
(require 'freemacs-no-littering)
;; No-littering:1 ends here

;; Emacs Defaults

;; Changes to the default settings of Emacs  Load the  the [[file:modules/defaults/freemacs-defaults.org][defaults module]].


;; [[file:init.org::*Emacs Defaults][Emacs Defaults:1]]
(require 'freemacs-defaults)
;; Emacs Defaults:1 ends here

;; Whicher

;; Load the [[./modules/startup/freemacs-whicher.org][Whicher module]].


;; [[file:init.org::*Whicher][Whicher:1]]
(require 'freemacs-whicher)
;; Whicher:1 ends here

;; Coding

;; Load the [[file:modules/coding/freemacs-coding.org][coding module]].


;; [[file:init.org::*Coding][Coding:1]]
(require 'freemacs-project)

(require 'freemacs-coding)

(require 'freemacs-autohotkey)
;; Coding:1 ends here

;; Embark

;; Load the [[./modules/completion/freemacs-embark.org][Embark module]]


;; [[file:init.org::*Embark][Embark:1]]
(require 'freemacs-embark)
;; Embark:1 ends here

;; Cape

;; Load the [[./modules/completion/freemacs-cape.org][Cape module]].


;; [[file:init.org::*Cape][Cape:1]]
(require 'freemacs-cape)
;; Cape:1 ends here

;; Consult

;; Load the [[./modules/completion/freemacs-consult.org][Consult module]].


;; [[file:init.org::*Consult][Consult:1]]
(require 'freemacs-consult)
;; Consult:1 ends here

;; Corfu

;; Load the [[./modules/completion/freemacs-corfu.org][Corfu module]]


;; [[file:init.org::*Corfu][Corfu:1]]
(require 'freemacs-corfu)
;; Corfu:1 ends here

;; Docker

;; Load the the [[file:modules/docker/freemacs-docker.org][docker module]].


;; [[file:init.org::*Docker][Docker:1]]
(require 'freemacs-docker)
;; Docker:1 ends here

;; YASnippet

;; Load the [[./modules/editing/freemacs-yasnippet.org][YASnippet module]].


;; [[file:init.org::*YASnippet][YASnippet:1]]
(require 'freemacs-yasnippet)
;; YASnippet:1 ends here

;; Elfeed

;; Load the [[./modules/elfeed/freemacs-elfeed.org][Elfeed Module]].


;; [[file:init.org::*Elfeed][Elfeed:1]]
(require 'freemacs-elfeed)
;; Elfeed:1 ends here

;; [[file:init.org::*Elfeed][Elfeed:2]]
(require 'freemacs-elfeed-protocol)
;; Elfeed:2 ends here

;; Dired

;; Load the [[file:modules/file-tools/freemacs-dired.org][Dired module]].


;; [[file:init.org::*Dired][Dired:1]]
(require 'freemacs-dired)
;; Dired:1 ends here

;; Dirvish

;; Load the [[./modules/file-tools/freemacs-dired.org][Dirvish Module]].


;; [[file:init.org::*Dirvish][Dirvish:1]]
(require 'freemacs-dirvish)
;; Dirvish:1 ends here

;; Trashed

;; Load the [[./modules/file-tools/freemacs-trashed.org][Trashed Module]].


;; [[file:init.org::*Trashed][Trashed:1]]
(require 'freemacs-trashed)
;; Trashed:1 ends here

;; Graphing

;; Load the [[file:modules/graphing/freemacs-graphing.org][graphing module]].


;; [[file:init.org::*Graphing][Graphing:1]]
(require 'freemacs-graphing)
;; Graphing:1 ends here

;; Ledger

;; Load the [[file:modules/math/freemacs-ledger.org][Ledger module]].


;; [[file:init.org::*Ledger][Ledger:1]]
(require 'freemacs-ledger)
;; Ledger:1 ends here

;; Marginalia

;; Loadt the [[./modules/completion/freemacs-marginalia.org][Marginalia module]].


;; [[file:init.org::*Marginalia][Marginalia:1]]
(require 'freemacs-marginalia)
;; Marginalia:1 ends here

;; Meow Mode

;; Load the [[./modules/editing/freemacs-meow.org][Meow Mode module]].


;; [[file:init.org::*Meow Mode][Meow Mode:1]]
(require 'freemacs-meow)
;; Meow Mode:1 ends here

;; Orderless

;; Load the [[./modules/completion/freemacs-orderless.el][Orderless module]].


;; [[file:init.org::*Orderless][Orderless:1]]
(require 'freemacs-orderless)
;; Orderless:1 ends here

;; Org

;; Load the [[./modules/org/freemacs-org.org][Org Mode module]].


;; [[file:init.org::*Org][Org:1]]
(require 'freemacs-org)
;; Org:1 ends here

;;  Org Contacts

;; Load the [[./modules/org/freemacs-org-contacts.org][Org Contacts Module]].

;; [[file:init.org::*Org Contacts][Org Contacts:1]]
(require 'freemacs-org-contacts)
;; Org Contacts:1 ends here

;; Org Mind Map

;; Load the [[./modules/org/freemacs-org-mm.org][Org Mind Map module]]/


;; [[file:init.org::*Org Mind Map][Org Mind Map:1]]
(require 'freemacs-org-mm)
;; Org Mind Map:1 ends here

;; Org-QL

;; Load the [[./modules/org/freemacs-org-ql.org][Org Ql Module]].


;; [[file:init.org::*Org-QL][Org-QL:1]]
(require 'freemacs-org-ql)
;; Org-QL:1 ends here

(require 'freemacs-orgsl)

;; Ox-publish

;; ~ox-publish.el~ makes it easy to create multi-page websites from Org Mode files by defining a publishing project. The configuration for this package can be found in the [[file:modules/publishing/freemacs-ox-publish.org][ox-publish module]].


;; [[file:init.org::*Ox-publish][Ox-publish:1]]
(require 'freemacs-ox-publish)
;; Ox-publish:1 ends here

;; Session

;; Load the [[./modules/session/freemacs-session.org][Session Module]].


;; [[file:init.org::*Session][Session:1]]
(require 'freemacs-session)
;; Session:1 ends here

;; Eshell

;; Load the [[./modules/shells/freemacs-eshell.org][Eshell Module]].


;; [[file:init.org::*Eshell][Eshell:1]]
(require 'freemacs-eshell)
;; Eshell:1 ends here

;; Eat

;; Load the [[./modules/shells/freemacs-eat.org][Eat Module]].


;; [[file:init.org::*Eat][Eat:1]]
(require 'freemacs-eat)
;; Eat:1 ends here

;; Vertico

;; Load the [[file:modules/completion/freemacs-completion.org][completion module]]


;; [[file:init.org::*Vertico][Vertico:1]]
(require 'freemacs-vertico)
;; Vertico:1 ends here

;; VTerm

;; Load the [[./modules/shells/freemacs-vterm.org][Vterm Module]].


;; [[file:init.org::*VTerm][VTerm:1]]
(require 'freemacs-vterm)
;; VTerm:1 ends here

;; Theme style

;; Load the [[./modules/theme/freemacs-theme.org][Theme Module]].


;; [[file:init.org::*Theme style][Theme style:1]]
(require 'freemacs-theme)
;; Theme style:1 ends here

;; Centered-Window Mode

;; Load the [[./modules/theme/freemacs-cwm.org][Centered Window module]].


;; [[file:init.org::*Centered-Window Mode][Centered-Window Mode:1]]
(require 'freemacs-cwm)
;; Centered-Window Mode:1 ends here

;; Nerd Icons

;; Load the [[./modules/theme/freemacs-nerd-icons.org][Nerd Icons module]].


;; [[file:init.org::*Nerd Icons][Nerd Icons:1]]
(require 'freemacs-nerd-icons)
;; Nerd Icons:1 ends here

;; Academic Writing

;; The [[file:modules/publishing/freemacs-academic-writing.org][academic writing module]] contains configurations to improve the environment for writing academic papers in Emacs. It contains configuration for the following packages:

;; + Academic Phrases :: A package that inserts common template phrases into academic papers
;; + Citar :: A citation tool that simplifies adding citations to documents
;; + Org Cite :: The built-in Org Mode citation management system


;; [[file:init.org::*Academic Writing][Academic Writing:1]]
(require 'freemacs-academic-writing)
;; Academic Writing:1 ends here

;; Spellchecking

;; The spellchecking module configures the spell checking environment in Emacs. A few of the changes made:

;; + Flyspell is on be default so that you do not need to remember to call ~ispell~.
;; + Hunspell is used as the default spellchecking backend as it is more modern and works on multiple operating systems.


;; [[file:init.org::*Spellchecking][Spellchecking:1]]
(require 'freemacs-spellcheck)
;; Spellchecking:1 ends here

;; \LaTeX{}

;; Configuration for working with \LaTeX documents can be found in the [[file:modules/publishing/freemacs-latex.org][\LaTeX{} module]].


;; [[file:init.org::*\LaTeX{}][\LaTeX{}:1]]
(require 'freemacs-latex)
;; \LaTeX{}:1 ends here

;; Markdown

;; Load the [[File:modules/publishing/freemacs-markdown.org][Markdown module]].


;; [[file:init.org::*Markdown][Markdown:1]]
(require 'freemacs-markdown)
;; Markdown:1 ends here

;; PDF

;; To improve the speed and to extend the ability to view PDF files in Emacs, the [[file:modules/publishing/freemacs-pdf.org][PDF module]] can be loaded.


;; [[file:init.org::*PDF][PDF:1]]
(require 'freemacs-pdf)
;; PDF:1 ends here

;; Help

;; The [[file:modules/help/freemacs-help.org][help module]] contains configuration that adds additional tools for help tools in Emacs:


;; [[file:init.org::*Help][Help:1]]
(require 'freemacs-help)
;; Help:1 ends here

;; YouTube

;; Load the [[./modules/youtube/freemacs-youtube.org][YouTube Module]].


;; [[file:init.org::*YouTube][YouTube:1]]
(require 'freemacs-youtube)
;; YouTube:1 ends here

;; Emacs Server

;; Load the [[file:modules/server/freemacs-server.org][server module]].


;; [[file:init.org::*Emacs Server][Emacs Server:1]]
(require 'freemacs-server)
;; Emacs Server:1 ends here

;; Custom Functions

;; This section contains custom functions that I have either created myself or borrowed from others to accomplish small tasks.


;; [[file:init.org::*Custom Functions][Custom Functions:1]]
;; Custom Function Definitions
;; Custom Functions:1 ends here

;; Sudo Find File

;; This function creates a ~sudo-find-file~ command that can be used to open files as the super user. This can be really useful when combined with Embark. This function was copied from https://karthinks.com/software/fifteen-ways-to-use-embark/.


;; [[file:init.org::*Sudo Find File][Sudo Find File:1]]
(whicher "sudo")
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
;; Sudo Find File:1 ends here

;; Performance Optimization End

;; Close off the ~let~ statement at the beginning of the init file.


;; [[file:init.org::*Performance Optimization End][Performance Optimization End:1]]
(setq gc-cons-threshold 800000)
)
;; Performance Optimization End:1 ends here

;; End

;; Add a final comment to indicate the end of the file.


;; [[file:init.org::*End][End:1]]
(provide 'init)

;;; init.el ends here
;; End:1 ends here
