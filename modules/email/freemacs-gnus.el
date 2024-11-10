(use-package gnus
  :straight (:type built-in)
  :defer t
  :hook
  (dired-mode . turn-on-gnus-dired-mode)
  :custom
  (gnus-init-file "~/.emacs.d/gnus.el")
  (gnus-icalendar-org-capture-file "~/org/inbox.org")
  (gnus-icalendar-org-capture-headline '("Calendar"))
  :config
  (require 'gnus-icalendar)
  (gnus-icalendar-setup)
  (gnus-icalendar-org-setup)
  (eval-after-load 'gnus-group
    '(progn
       (defhydra hydra-gnus-group (:color blue)
         "
  [_A_] Remote groups (A A) [_g_] Refresh
  [_L_] Local groups        [_\\^_] List servers
  [_c_] Mark all read       [_m_] Compose new mail
  [_G_] Search mails (G G) [_#_] Mark mail
  "
         ("A" gnus-group-list-active)
         ("L" gnus-group-list-all-groups)
         ("c" gnus-topic-catchup-articles)
         ("G" dianyou-group-make-nnir-group)
         ("g" gnus-group-get-new-news)
         ("^" gnus-group-enter-server-mode)
         ("m" gnus-group-new-mail)
         ("#" gnus-topic-mark-topic)
         ("q" nil))
       ;; y is not used by default
       (define-key gnus-group-mode-map "y" 'hydra-gnus-group/body)))
  
  ;; gnus-summary-mode
  (eval-after-load 'gnus-sum
    '(progn
       (defhydra hydra-gnus-summary (:color blue)
         "
  [_s_] Show thread   [_F_] Forward (C-c C-f)
  [_h_] Hide thread   [_e_] Resend (S D e)
  [_n_] Refresh (/ N) [_r_] Reply
  [_!_] Mail -> disk  [_R_] Reply with original
  [_d_] Disk -> mail  [_w_] Reply all (S w)
  [_c_] Read all      [_W_] Reply all with original (S W)
  [_#_] Mark          [_G_] Search mails
  "
         ("s" gnus-summary-show-thread)
         ("h" gnus-summary-hide-thread)
         ("n" gnus-summary-insert-new-articles)
         ("F" gnus-summary-mail-forward)
         ("!" gnus-summary-tick-article-forward)
         ("d" gnus-summary-put-mark-as-read-next)
         ("c" gnus-summary-catchup-and-exit)
         ("e" gnus-summary-resend-message-edit)
         ("R" gnus-summary-reply-with-original)
         ("r" gnus-summary-reply)
         ("W" gnus-summary-wide-reply-with-original)
         ("w" gnus-summary-wide-reply)
         ("#" gnus-topic-mark-topic)
         ("G" dianyou-group-make-nnir-group)
         ("q" nil))
       ;; y is not used by default
       (define-key gnus-summary-mode-map "y" 'hydra-gnus-summary/body)))
  
  (eval-after-load 'gnus-art
    '(progn
       (defhydra hydra-gnus-article (:color blue)
         "
  [_o_] Save attachment        [_F_] Forward
  [_v_] Play video/audio       [_r_] Reply
  [_d_] CLI to download stream [_R_] Reply with original
  [_b_] Open external browser  [_w_] Reply all (S w)
  [_f_] Click link/button      [_W_] Reply all with original (S W)
  [_g_] Focus link/button
  "
         ("F" gnus-summary-mail-forward)
         ("r" gnus-article-reply)
         ("R" gnus-article-reply-with-original)
         ("w" gnus-article-wide-reply)
         ("W" gnus-article-wide-reply-with-original)
         ("o" gnus-mime-save-part)
         ("v" my-w3m-open-with-mplayer)
         ("d" my-w3m-download-rss-stream)
         ("b" my-w3m-open-link-or-image-or-url)
         ("f" w3m-lnum-follow)
         ("g" w3m-lnum-goto)
         ("q" nil))
       ;; y is not used by default
       (define-key gnus-article-mode-map "y" 'hydra-gnus-article/body)))
  
  (eval-after-load 'message
    '(progn
       (defhydra hydra-message (:color blue)
         "
  [_c_] Complete mail address
  [_a_] Attach file
  [_s_] Send mail (C-c C-c)
  "
         ("c" counsel-bbdb-complete-mail)
         ("a" mml-attach-file)
         ("s" message-send-and-exit)
         ("i" dianyou-insert-email-address-from-received-mails)
         ("q" nil))))
  
  (defun message-mode-hook-hydra-setup ()
    (local-set-key (kbd "C-c C-y") 'hydra-message/body))
  (add-hook 'message-mode-hook 'message-mode-hook-hydra-setup))

;; Hydras for Gnus

;; Use Hydras for Gnus to make remembering keybindings easier.

(eval-after-load 'gnus-group
  '(progn
     (defhydra hydra-gnus-group (:color blue)
       "
[_A_] Remote groups (A A) [_g_] Refresh
[_L_] Local groups        [_\\^_] List servers
[_c_] Mark all read       [_m_] Compose new mail
[_G_] Search mails (G G) [_#_] Mark mail
"
       ("A" gnus-group-list-active)
       ("L" gnus-group-list-all-groups)
       ("c" gnus-topic-catchup-articles)
       ("G" dianyou-group-make-nnir-group)
       ("g" gnus-group-get-new-news)
       ("^" gnus-group-enter-server-mode)
       ("m" gnus-group-new-mail)
       ("#" gnus-topic-mark-topic)
       ("q" nil))
     ;; y is not used by default
     (define-key gnus-group-mode-map "y" 'hydra-gnus-group/body)))

;; gnus-summary-mode
(eval-after-load 'gnus-sum
  '(progn
     (defhydra hydra-gnus-summary (:color blue)
       "
[_s_] Show thread   [_F_] Forward (C-c C-f)
[_h_] Hide thread   [_e_] Resend (S D e)
[_n_] Refresh (/ N) [_r_] Reply
[_!_] Mail -> disk  [_R_] Reply with original
[_d_] Disk -> mail  [_w_] Reply all (S w)
[_c_] Read all      [_W_] Reply all with original (S W)
[_#_] Mark          [_G_] Search mails
"
       ("s" gnus-summary-show-thread)
       ("h" gnus-summary-hide-thread)
       ("n" gnus-summary-insert-new-articles)
       ("F" gnus-summary-mail-forward)
       ("!" gnus-summary-tick-article-forward)
       ("d" gnus-summary-put-mark-as-read-next)
       ("c" gnus-summary-catchup-and-exit)
       ("e" gnus-summary-resend-message-edit)
       ("R" gnus-summary-reply-with-original)
       ("r" gnus-summary-reply)
       ("W" gnus-summary-wide-reply-with-original)
       ("w" gnus-summary-wide-reply)
       ("#" gnus-topic-mark-topic)
       ("G" dianyou-group-make-nnir-group)
       ("q" nil))
     ;; y is not used by default
     (define-key gnus-summary-mode-map "y" 'hydra-gnus-summary/body)))

(eval-after-load 'gnus-art
  '(progn
     (defhydra hydra-gnus-article (:color blue)
       "
[_o_] Save attachment        [_F_] Forward
[_v_] Play video/audio       [_r_] Reply
[_d_] CLI to download stream [_R_] Reply with original
[_b_] Open external browser  [_w_] Reply all (S w)
[_f_] Click link/button      [_W_] Reply all with original (S W)
[_g_] Focus link/button
"
       ("F" gnus-summary-mail-forward)
       ("r" gnus-article-reply)
       ("R" gnus-article-reply-with-original)
       ("w" gnus-article-wide-reply)
       ("W" gnus-article-wide-reply-with-original)
       ("o" gnus-mime-save-part)
       ("v" my-w3m-open-with-mplayer)
       ("d" my-w3m-download-rss-stream)
       ("b" my-w3m-open-link-or-image-or-url)
       ("f" w3m-lnum-follow)
       ("g" w3m-lnum-goto)
       ("q" nil))
     ;; y is not used by default
     (define-key gnus-article-mode-map "y" 'hydra-gnus-article/body)))

(eval-after-load 'message
  '(progn
     (defhydra hydra-message (:color blue)
       "
[_c_] Complete mail address
[_a_] Attach file
[_s_] Send mail (C-c C-c)
"
       ("c" counsel-bbdb-complete-mail)
       ("a" mml-attach-file)
       ("s" message-send-and-exit)
       ("i" dianyou-insert-email-address-from-received-mails)
       ("q" nil))))

(defun message-mode-hook-hydra-setup ()
  (local-set-key (kbd "C-c C-y") 'hydra-message/body))
(add-hook 'message-mode-hook 'message-mode-hook-hydra-setup)

;; End

;; Tell Emacs what package this file provides.

(provide 'freemacs-gnus)

;;; freemacs-gnus.el ends here.
