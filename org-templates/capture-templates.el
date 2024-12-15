;;  # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-
 
;; #+title:  Org Capture Templates
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2024-12-14 21:03:10 thomas>
;; #+description: A series of org capture templates for org mode.


;; Collect the org capture teplates and add them to the list of templates.

(mapc (lambda (x) (add-to-list 'org-capture-templates x)) 
      '(
        ("f" "Future Reminders")
        
        ("fs" "Someday/Maybe Item"
         entry
         (file "~/org/agenda/someday.org")
         "* %?\n%x")
        
        ("ft" "Tickler file item"
         entry
         (file "~/org/agenda/tickler.org")
         "* %?\n%^{Scheduled}t\n\n%x")
        ("t" "To Do Items")
        
        ("p" "Projects item"
         entry
         (file "~/org/agenda//projects.org")
         "* %? [\%] %^g:project:")
        
        ("tb" "Scheduled and Deadline TODO"
         entry
         (file+headline "~/org/agenda/inbox.org" "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\nSCHEDULED: %^{Scheduled}t DEADLINE: %^{Deadline}t\n %(my/org-contacts)")
        
        ("td" "Deadline TODO"
         entry
         (file+headline "~/org/agenda//inbox.org" "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\nSCHEDULED: DEADLINE: %^{Deadline}t\n%x")
        
        ("th" "Habit Item"
         entry
         (file+headline "~/org/agenda/inbox.org" "Habits")
         "* TODO %^{Title} %^G\n:PROPERTIES:\n:STYLE: habit\n:END:")
        
        ("to" "Deleegated Work Task"
         entry
         (file "~/org/agenda//work.org")
         "* WAITING [#%^{Priority|B|A|C}] %^{Title} %^G\n:PROPERTIES:\n:WAITING_ON: %(or\n\n%x")
        
        ("ts" "Scheduled TODO"
         entry
         (file+headline "~/org/agenda/inbox.org" "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\nSCHEDULED: %^{Scheduled}t\n\n%x")
        
        ("tu" "Unscheduled TODO"
         entry
         (file+headline "~/org/agenda/inbox.org" "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\n\n%x")
        
        ("c" "Calendar Entries")
        
        ("cw"
         "Work Calendar"
         entry
         (file+olp+datetree "~/org/agenda/work-calendar.org")
         "* %^{Title}\n%^{LOCATION|Virtual}p\n%T\n"
         :time-prompt t
         :unnarrowed t)
        
        ("cp"
         "Personal Calendar"
         entry
         (file+olp+datetree "~/org/agenda/personal-calendar.org")
         "* %^{Title}\n%^{LOCATION}p\n%T\n"
         :time-prompt t
         :unnarrowed t)
        ))
