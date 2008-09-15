;; Red Hat Linux default .emacs initialization file

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
       (global-font-lock-mode t)
))

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

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
 
;;(custom-set-variables
;; (transient-mark-mode t))

;; UTF-8
(require 'un-define "un-define" t)
(set-buffer-file-coding-system 'utf-8 'utf-8-unix)
(set-default buffer-file-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-default default-buffer-file-coding-system 'utf-8-unix)

;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
(setq
backup-by-copying t      ; don't clobber symlinks
    backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
    delete-old-versions t
    kept-new-versions 6
    kept-old-versions 2
    version-control t)       ; use versioned backups

;;LoadPath
(add-to-list 'load-path "~/.emacs.d/")

;;Line Numbers
(require 'linum)

;;;;Smarty Mode
(require 'smarty-mode)

