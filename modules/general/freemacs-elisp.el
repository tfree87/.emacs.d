(defun any (predicate list)
  "Returns T if any items in LIST meet the conditions of predicate function
  PREDICATE without modifying the list."
  (cond
   ((null list) nil)
   ((funcall predicate (car list)) t)
   (t (any predicate (cdr list)))))

;; End

;; Tell Emacs what package this file provides.


(provide 'freemacs-elisp)

;;; freemacs-elisp.el ends here.
