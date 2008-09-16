; Red Hat Linux default .emacs initialization file

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; Start quietly
(setq inhibit-startup-message t)

;; set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key [backspace] 'backward-kill-word)
(global-set-key [(control backspace)] 'backward-delete-char)

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
       (global-font-lock-mode t)
))

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Replace "yes or no" with y or n
(defun yes-or-no-p (arg)
  "An alias for y-or-n-p, because I hate having to type 'yes' or 'no'."
  (y-or-n-p arg))

;; I Like to know the time.  24 hour, preferably.
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)

;; Load whitespace.el library. Nukes trailing whitespace from the ends
;; of lines, and deletes excess newlines from the ends of buffers.
;;
;; get it from: http://www.dsmit.com/lisp/
;(require 'whitespace)
;(setq whitespace-auto-cleanup t)
;(whitespace-global-mode 1)

;; Insert function comment file template from ~/templates directory
;(defun insert-function-comment ()
;  "Insert function comment"
;  (interactive)
;  (insert-file-contents "~/templates/function.cpp"))
;(global-set-key [f6] 'insert-function-comment)


;; Enable wheelmouse support by default
(if (not running-xemacs)
    (require 'mwheel) ; Emacs
  (mwheel-install) ; XEmacs
)

(setq default-tab-width 4)

;; Fix the worse part about emacs: indentation craziness
;;   1. When I hit the TAB key, I always want a TAB character inserted
;;   2. Don't automatically indent the line I am editing.
;;   3. When I hit C-j, I always want a newline, plus enough tabs to put me on
;;      the same column I was at before.
;;   4. When I hit the BACKSPACE key to the right of a TAB character, I want the
;;      TAB character deleted-- not replaced with tabwidth-1 spaces.
(defun newline-and-indent-relative ()
  "Insert a newline, then indent relative to the previous line."
  (interactive "*") (newline) (indent-relative))
(defun indent-according-to-mode () ())
(defalias 'newline-and-indent 'newline-and-indent-relative)
(defun my-c-hook ()
  (defalias 'c-electric-backspace 'delete-backward-char)
  (defun c-indent-command () (interactive "*") (self-insert-command 1)))
(add-hook 'c-mode-common-hook 'my-c-hook)
(defun indent-region-with-tab ()
  (interactive)
  (save-excursion
	(if (< (point) (mark)) (exchange-point-and-mark))
	(let ((save-mark (mark)))
	    (if (= (point) (line-beginning-position)) (previous-line 1))
		  (goto-char (line-beginning-position))
		    (while (>= (point) save-mark)
			  (goto-char (line-beginning-position))
			  (insert "\t")
			  (previous-line 1)))))
;;(global-set-key [?\C-x tab] 'indent-region-with-tab)
(global-set-key [f4] 'indent-region-with-tab)
(defun unindent-region-with-tab ()
  (interactive)
  (save-excursion
	(if (< (point) (mark)) (exchange-point-and-mark))
	(let ((save-mark (mark)))
	    (if (= (point) (line-beginning-position)) (previous-line 1))
		  (goto-char (line-beginning-position))
		    (while (>= (point) save-mark)
			  (goto-char (line-beginning-position))
			  (if (= (string-to-char "\t") (char-after (point))) (delete-char 1))
			  (previous-line 1)))))
 
;; Turn on selection
;;;;;;;;;;;;;;;;;;;;;;;
(setq transient-mark-mode 't highlight-nonselected-windows 't)

;; UTF-8
;;;;;;;;;;
(require 'un-define "un-define" t)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)

;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
;(setq
;backup-by-copying t      ; don't clobber symlinks
;    backup-directory-alist
;    '(("." . "~/.saves"))    ; don't litter my fs tree
;    delete-old-versions t
;    kept-new-versions 6
;    kept-old-versions 2
;    version-control t)       ; use versioned backups

;; Don't make backup files
(setq make-backup-files nil backup-inhibited t)


;; Set LoadPath
;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/")

;; Line Numbers
;;;;;;;;;;;;;;;;;
(require 'linum)

;; Smarty Mode
;;;;;;;;;;;;;;;
(require 'smarty-mode)

;; PHP Doc
;;;;;;;;;;;;
(defun php-doc-paragraph-boundaries () 
  (setq paragraph-separate "^[ \t]*\\(\\(/[/\\*]+\\)\\|\\(\\*+/\\)\\|\\(\\*?\\)\\|\\(\\*?[ \t]*@[[:alpha:]]+\\([ \t]+.*\\)?\\)\\)[ \t]*$")
  (setq paragraph-start (symbol-value 'paragraph-separate)))

(add-hook 'php-mode-user-hook 'php-doc-paragraph-boundaries)

;; PHP mode
;;;;;;;;;;;;;;;;;
(require 'php-mode)

;; Set up php mode
(add-hook 'php-mode-hook
          '(lambda ()
             (c-set-style "java") ))
			 ;; Some keybindings
			 (global-set-key "\C-c <left>" (quote php-beginning-of-defun))
			 (global-set-key "\C-c <right>" (quote php-end-of-defun))

(defun prefix-region (point mark string)
  "Prefix the region between [point] and [mark] with [string]"
  (interactive "*r\nsPrefix: ")
  (save-excursion
    (save-restriction
      (narrow-to-region point mark)
        (replace-regexp "^" string))))

;; Bubble Buffer
;;;;;;;;;;;;;;;;
(require 'bubble-buffer)
(global-set-key [f12] 'bubble-buffer-next)
(global-set-key [f11] 'bubble-buffer-previous)

;; IDO
;;;;;;;;;
(require 'ido)
(ido-mode t)

;; libempd
;;;;;;;;
(require 'mpcel)

;; Org Mode
;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/orgmode/lisp")
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-agenda-files (list "~/environment/org/work.org"
                             "~/environment/org/home.org"))
(setq org-log-done t)

