;;; early-init.el --- Emacs early init -*- lexical-binding: t -*-
;; 

;; Author: Thomas Freeman
;; Maintainer: Thomas Freeman
;; Created: 09 Jan 2022

;; URL: https://github.com/tfree87/.emacs.d

;; This file is an early-init file for Emacs. It will be executed before
;; init.el when emacs is loaded.

;; This file IS NOT intended to be edited! It was generated by init.org.

;;; Commentary:

;; For documentation and for editing this file, see the init.org in the
;; github repository tfree87/.emacs.d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Code:

(setq gc-cons-threshold 500000000)

(setq native-comp-deferred-compilation nil)

(setq package-enable-at-startup nil)

(setq-default inhibit-redisplay t
              inhibit-message t)

(add-hook 'window-setup-hook
          (lambda ()
            (setq-default inhibit-redisplay nil
                          inhibit-message nil)
            (redisplay)))

(set-language-environment "UTF-8")
(setq default-input-method nil)

(provide 'early-init)

;;; early-init.el ends here
