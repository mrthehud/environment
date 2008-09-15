;;; mpcel.el --- A mpd client

;; Copyright (C)  2006  Jean-Baptiste Bourgoin <monsieur.camille@xxxxxxxxx>

;; Author: Jean-Baptiste Bourgoin <monsieur.camille@xxxxxxxxx>
;; Maintainer: Jean-Baptiste Bourgoin <monsieur.camille@xxxxxxxxx>
;; Version: 1.O
;; Keywords: music
;; URL: http://jbbourgoin.free.fr/website/programs/elisp/mpcel.el.html

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.
;; mpcel.el v0.1
;;
;; Commentary
;;
;; Installation :
;; 1) install mpc, see http://www.musicpd.org/mpc.shtml
;; 2) type in your .emacs :
;;     (load "/path/to/mpcel.el")
;; 3) evaluate the previous expression, or restart Emacs.


;; MPCEL Version
(defun mpcel-version ()
  "mpcel version. This is the first."
  (interactive)
  (message "mpcel version 1 - written in 2006 by Bourgoin Jean-Baptiste"))


;; MPD

;; Start mpd daemon :
(defun mpcel-mpd-start ()
  "Start the mpd daemon"
  (interactive)
  (shell-command-to-string "mpd")
  (message "mpd id ready"))

;; Stop mpd :
 (defun mpcel-mpd-stop ()
   "Stop the mpd daemon"
   (interactive)
   (shell-command "killall mpd")
   (message "mpd is stoped"))

;; update database
(defun mpcel-mpd-update ()
  "Update database"
  (interactive)
  (shell-command-to-string "mpc update")
  (message "i'm updating the database"))



;; MPC

;; Player control :

; mpc play track number ### :
(defun mpcel-play (number)
  "Play the ## track number with mpc"
  (interactive "MTrack number (leave blank for resume): ")
  (let (mpcplay)
    (setq mpcplay (concat "mpc play " number))
    (shell-command-to-string mpcplay))
  (message (concat "playing : " 
                   (shell-command-to-string "mpc status | head -n1"))))

;; mpc stop playing music :
(defun mpcel-stop ()
  "Stop playing music in mpd"
  (interactive)
  (shell-command-to-string "mpc stop")
  (message "stop playing music"))

;; toggle random mode.
(defun mpcel-random-mode (onoroff)
  "mpcel : toggle random mode."
  (interactive 
   "MRandomize ? ( \"on\" or \"off\") : ")
  (let (randomode)
    (setq randomode
          (concat "mpc random " onoroff))
    (shell-command-to-string randomode)
    (message (concat "Random mode : " onoroff))))

;; toggle random mode.
(defun mpcel-repeat-mode (offoron)
  "mpcel : toggle repeat mode."
  (interactive 
   "MRandomize ? ( \"on\" or \"off\") : ")
  (let (repeatmode)
    (setq repeatmode
          (concat "mpc reapeat " offoron))
    (shell-command-to-string repeatmode)
    (message (concat "Repeat mode : " offoron))))

;; mpc pause playing music :
(defun mpcel-pause ()
  "Pause music in mpd"
  (interactive)
  (shell-command-to-string "mpc pause")
  (message (concat "status : "
           (shell-command-to-string "mpc status | head -1"))))

;; mpc play the next music :
(defun mpcel-next ()
  "Play the next music in mpd's playlist"
  (interactive)
  (shell-command-to-string "mpc next")
  (message (concat "playing : "
           (shell-command-to-string "mpc status | head -1"))))

;; mpc play the previous music :
(defun mpcel-prev ()
  "Play the previous music in mpd's playlist"
  (interactive)
  (shell-command-to-string "mpc prev")
  (message (concat "playing : "
           (shell-command-to-string "mpc status | head -1"))))

;; Crossfading
(defun mpcel-crossfade (cfade)
  "mpd : Sets  and  gets  the  current amount of crossfading between song"
  (interactive "MCrossfading between songs in seconds (0 to disable) : ")
  (let (sccross)
    (setq sccross (concat "mpc crossfade " cfade))
    (shell-command-to-string sccross)
    (message 
     (concat "amount of crossfading in seconds : " cfade))))

;; set the volume
(defun mpcel-volume (vol)
  "mpcel : increase or decrease volume"
  (interactive 
   "M[+-]value : ")
  (let (volume)
    (setq volume
          (concat "mpc volume " vol))
    (shell-command-to-string volume)))


;; Playlist control :

;; prints the playlist :
(defun mpcel-plist-print ()
  "Prins entire mpd's playlist"
  (interactive)
  (shell-command 
   "mpc --format \"[%artist%--[%album%--[%title%]]]|[%file%]\" playlist"))

;; clear playlist
(defun mpcel-plist-clear ()
  "Clear the mpd playlist"
  (interactive)
  (shell-command-to-string "mpc clear")
  (message "the playlist is cleared"))

;; add song :
(defun mpcel-add-songs (art rest)
  "Add songs in the mpd playlist"
  (interactive 
   "MArtist : \nMChoose album or song (type ^.* to pass) : ")
  (let (mpcadd)
    (setq mpcadd 
          (concat 
           "mpc search artist " art " | grep -i " rest " | mpc add"))
    (shell-command-to-string mpcadd)
    (message (concat "Tracks : "
                   (shell-command-to-string "mpc playlist | wc -l")))))
;; shuffle playlist
(defun mpcel-plist-shuffle ()
  "mpcel : a Troll come to make your playlist untidiness"
  (interactive)
  (shell-command-to-string "mpc shuffle")
  (message "what a mess !"))

;; move song
(defun mpcel-plist-move (pos1 pos2)
  "mpcel : Moves song at position x to the postion y in the playlist"
  (interactive 
   "MMove song number : \nMTo : ")
  (let (movesong)
    (setq movesong 
          (concat "mpc move " pos1 " " pos2))
    (shell-command-to-string movesong)
    (message (concat "Track number " pos1 " move to position " pos2))))

;; crop -- Remove all songs except for the currently playing song:
(defun mpcel-plist-crop ()
  "mpd : Remove all songs except for the currently playing song"
  (interactive)
  (shell-command-to-string "mpc crop")
  (message 
   (concat "The only survivor is : " 
           (shell-command-to-string "mpc status | head -1"))

))

(provide 'mpcel)
