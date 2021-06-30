(in-package :stumpwm)


(defcommand volume-up () ()
    (run-shell-command "amixer set Master '5.0%+'" t)
    (message "Volume: ~A" (run-shell-command "amixer get Master | grep % |
    awk '{print $4}' | sed 's/[^0-9]//g'" t)))


(defcommand volume-down () ()
    (run-shell-command "amixer set Master '5.0%-'" t)
    (message "Volume: ~A" (run-shell-command "amixer get Master | grep % |
    awk '{print $4}' | sed 's/[^0-9]//g'" t)))

(defcommand display-battery () ()
    (message "Bat0: ~A~%Bat1: ~A" 
        (uiop:read-file-string "/sys/class/power_supply/BAT0/capacity")
        (uiop:read-file-string "/sys/class/power_supply/BAT1/capacity")))

(defcommand neofetch () ()
    (message "~A" 
         (run-shell-command "neofetch --stdout" t)))

(defcommand screenshot (name selectp)
    ((:string "File name: ") (:y-or-n "Select? "))
  (let* ((pic-dir (uiop:run-program '("xdg-user-dir" "PICTURES") :output '(:string :stripped t)))
	 (directory (uiop:subpathname* pic-dir "screenshots/"))
         (file-name (make-pathname :directory (pathname-directory directory) :name name :type "png")))
    (ensure-directories-exist file-name)
    (uiop:launch-program (list* "scrot" "--overwrite" "--delay" "1"
                                "--exec""notify-send Scrot 'Done Screenshot'; image_clipboard $f"
                                (namestring file-name)
                                (when selectp '("--select"))))))
  

      
