(in-package :stumpwm)

(setf *startup-message* nil)


(setf *colors* 
    `("#181818" ;black
      "#ab4642" ;red
      "#a1b56c" ;green
      "#f7ca88" ;yellow
      "#7cafc2" ;blue
      "#ba8baf" ;magenta
      "#86c1b9" ;cyan
      "#e8e8e8" ;white
      ))

(update-color-map (current-screen))

(set-fg-color "#e8e8e8")
(set-bg-color "#181818")
(set-border-color "#ab4642")


(setf *mode-line-background-color* "#181818")
(setf *mode-line-foreground-color* "#e8e8e8")
(setf *mode-line-border-color* "#282828")

(set-msg-border-width 1)

(setf *window-border-style* :thin)
