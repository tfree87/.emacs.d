;;  # -*-eval: (add-hook 'after-save-hook (lambda ()(org-babel-tangle)) nil t);-*-
 
;; #+title:  Org Capture Templates
;; #+author: Thomas Freeman
;; #+date: Time-stamp: <2024-12-19 08:45:32 abc>
;; #+description: A series of org capture templates for org mode.


;; Collect the org capture teplates and add them to the list of templates.

(mapc (lambda (x) (add-to-list 'org-capture-templates x)) 
      `(
        ("f" "Future Reminders")
        
        ("fs" "Someday/Maybe Item"
         entry
         (file ,(concat (car org-agenda-files) "/someday.org"))
         "* %?\n%x"
         :empty-lines 1)
        
        ("ft" "Tickler file item"
         entry
         (file ,(concat (car org-agenda-files) "/tickler.org"))
          "* %?\n%^{Scheduled}t\n\n%x"
          :empty-lines 1)
        ("t" "To Do Items")
        
        ("p" "Projects item"
         entry
         (file ,(concat (car org-agenda-files) "/projects.org"))
         "* [#%^{Priority|B|A|C}] %^{Title} [\%] %^G:project:\n%?"
         :empty-lines 1)
        
        ("tb" "Scheduled and Deadline TODO"
         entry
         (file+headline ,(concat (car org-agenda-files) "/inbox.org") "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\nSCHEDULED: %^{Scheduled}t DEADLINE: %^{Deadline}t\n %(my/org-contacts)"
         :empty-lines 1)
        
        ("td" "Deadline TODO"
         entry
         (file+headline ,(concat (car org-agenda-files) "/inbox.org") "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\nSCHEDULED: DEADLINE: %^{Deadline}t\n%x"
         :empty-lines 1)
        
        ("th" "Habit Item"
         entry
         (file+headline ,(concat (car org-agenda-files) "/inbox.org") "Habits")
         "* TODO %^{Title} %^G\n:PROPERTIES:\n:STYLE: habit\n:END:"
         :empty-lines 1)
        
        ("to" "Deleegated Work Task"
         entry
         (file ,(concat (car org-agenda-files) "/work.org"))
         "* WAITING [#%^{Priority|B|A|C}] %^{Title} %^G\n:PROPERTIES:\n:WAITING_ON: %(or\n\n%x"
         :empty-lines 1)
        
        ("ts" "Scheduled TODO"
         entry
         (file+headline ,(concat (car org-agenda-files) "/inbox.org") "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\nSCHEDULED: %^{Scheduled}t\n\n%x"
         :empty-lines 1)
        
        ("tu" "Unscheduled TODO"
         entry
         (file+headline ,(concat (car org-agenda-files) "/inbox.org") "Tasks")
         "* TODO [#%^{Priority|B|A|C}] %^{Title} %^G\n\n%x"
         :empty-lines 1)
        ("c" "Calendar Entries")
        
        ("cw"
         "Work Calendar"
         entry
         (file+olp+datetree ,(concat (car org-agenda-files) "/work-calendar.org"))
         "* %^{Title}\n%^{LOCATION|Virtual}p%T\n"
         :time-prompt t
         :unnarrowed t
         :empty-lines 1)
        
        ("cp"
         "Personal Calendar"
         entry
         (file+olp+datetree ,(concat (car org-agenda-files) "/personal-calendar.org"))
         "* %^{Title}\n%^{LOCATION}p%T\n\n"
         :time-prompt t
         :unnarrowed t
         :empty-lines 1)
        ("s" "Shopping Lists")
        
        ("sh" "Hardware Store"
         checkitem
         (file+headline ,(concat (car org-agenda-files) "/shopping.org") "Hardware"))
        
        ("sf" "Food and Groceries"
         checkitem
         (file+headline ,(concat (car org-agenda-files) "/shopping.org") "Food and Groceries"))
        
        ("sg" "Gifts"
         checkitem
         (file+headline ,(concat (car org-agenda-files) "/shopping.org") "Gifts"))
        
        ("sh" "Household"
         checkitem
         (file+headline ,(concat (car org-agenda-files) "/shopping.org") "Household Items"))
        
        ("sp" "Project Supplies"
         checkitem
         (file+headline ,(concat (car org-agenda-files) "/shopping.org") "Project Supplies"))
        
        ("se" "Electronics"
         checkitem
         (file+headline ,(concat (car org-agenda-files) "/shopping.org") "Electronnics"))
        ("r" "Periodic Reflections")
        
        ("rd" "Daily Enty"
         entry
         (file+olp+datetree "~/org/reflection/daily.org")
         "* Daily Gratitude\n\n- I am grateful for %^{I am grateful for...}\n\n* Daily Affirmation\n\n%^{Affirmation}\n\n* Daily Goal\n\n%^{Today's Goal}"
         :empty-lines 1)
        ("rw" "Week Begin"
         entry
         (file+olp+datetree "~/org/reflection/weekly.org")
         "* Weekly Goal\n\n- :Goal: %^{Goal}\n- :Reward: %^{Reward}\n\n* Weekly Priorities\n\n1. %^{1st Priority}\n2. %^{2nd Priority}\n3. %^{3rd Priority}\n\n* Exicted About\n1. %^{Excited About 1}\n2. %^{ Excited About 2}\n3.  %^{Excited About 3}"
         :tree-type week
         :empty-lines 1)
        
        ("rW" "Week End"
         entry
         (file+olp+datetree "~/org/reflection/weekly.org")
         "* Reflectioni\n\n** Lessons Learned\n\n1. %^{1st Lesson}\n2. %^{2nd Lesson}\n3. %^{3rd Lesson}\n** This Week's Wins\n\n1. %^{1st Win}\n2. %^{2nd Win}\n3. %^{3rd Win}\n\n** Improvments for Next Week\n1. %^{1st Improvement}\n2. %^{2nd Improvement}\n3. %^{3rd Improvement}"
         :tree-type week
         :empty-lines 1)
        ))
