(in-package :stumpwm)
(set-prefix-key (kbd "s-s"))

(define-key *root-map* (kbd "t") "exec st")
(define-key *root-map* (kbd "u") "display-battery")
(define-key *root-map* (kbd "d") "exec")
(define-key *root-map* (kbd "s") "vsplit")
 
(define-key *top-map* (kbd "XF86MonBrightnessDown") "exec light -U 10" )
(define-key *top-map* (kbd "XF86MonBrightnessUp") "exec light -A 10")

(define-key *top-map* (kbd "XF86AudioMute") "exec amixer -q -D pulse sset Master toggle")
(define-key *top-map* (kbd "XF86AudioLowerVolume") "volume-down")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "volume-up")
