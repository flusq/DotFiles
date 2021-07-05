(use-modules (guix packages)
             (guix download)
             (guix gexp)
             (guix git-download)
             (guix build-system trivial)
             (gnu)
             (gnu system nss))

(use-service-modules avahi base dbus desktop networking sddm xorg)
(use-package-modules admin certs gnome linux shells)

(use-modules (gnu) 
		(gnu system nss)
		(gnu packages)
		(gnu packages wm)
		(gnu services)
		(gnu services base)
		(gnu services desktop)
		(gnu services xorg)
		(gnu services shepherd)
		(gnu services sound)
		(gnu packages networking))
		
(use-modules (nongnu packages linux)
	                  (nongnu system linux-initrd))

(use-modules (srfi srfi-1))

(use-service-modules desktop 
			xorg
			base
			networking
			ssh)

(use-package-modules
		certs
		lisp
		gnuzilla
		emacs)

(operating-system
  (host-name "thinkpad")
  (timezone "Europe/Kiev")
  (locale "en_US.utf8")

  ;; Choose US English keyboard layout.  The "altgr-intl"
  ;; variant provides dead keys for accented characters.

  (keyboard-layout (keyboard-layout "us,ru" #:options '("grp:alt_shift_toggle")))

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/efi.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (target "/boot/efi")
                (keyboard-layout keyboard-layout)))

  ;; Specify a mapped device for the encrypted root partition.
  ;; The UUID is that returned by 'cryptsetup luksUUID'.
  (mapped-devices
   (list (mapped-device
          (source (uuid "uuid"))
          (target "root")
          (type luks-device-mapping))))

  (file-systems (append
                 (list (file-system
                         (device (file-system-label "root"))
                         (mount-point "/")
                         (type "ext4")
                         (dependencies mapped-devices))
                       (file-system
                         (device (uuid "uuid" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))


  ;; This is where we specify system-wide packages.
  (packages (append (list nss-certs
			emacs
			stumpwm
			icecat) %base-packages))

      (kernel linux)
        (initrd microcode-initrd)
	  (firmware (list linux-firmware))

  ;; Add GNOME and Xfce---we can choose at the log-in screen
  ;; by clicking the gear.  Use the "desktop" services, which
  ;; include the X11 log-in service, networking with
  ;; NetworkManager, and more.
  (users (cons (user-account
	(name "runner")
	(group "users")
	(shell (file-append zsh "/bin/zsh"))
	(supplementary-groups '("wheel" "netdev" "audio" "video")))
		                              %base-user-accounts))

  (services
   (cons*
  	(bluetooth-service
	 #:auto-enable? #t)
	(service slim-service-type	
		     (slim-configuration
			  (xorg-configuration
			   (xorg-configuration
				(keyboard-layout keyboard-layout)))))
	(remove (lambda(service)	
			  (eq? (service-kind service) gdm-service-type))
			%desktop-services)))
  

  

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))



