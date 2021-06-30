(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fringe-mode 0 nil (fringe))
 '(lisp-mode-hook nil)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(pdf-tools base16-theme planet-theme nimbus-theme sly slime ample-theme tramp-auto-auth ssh tramp el-get virtualenvwrapper virtualenv flycheck jedi git project which-key soothe-theme reverse-im company-emoji company-emacs-eclim company company-posframe telega ## vterm))
 '(projectile-auto-discover nil)
 '(scroll-bar-mode nil)
 '(telega-filter-button-width 25)
 '(telega-filter-custom-expand nil)
 '(telega-root-default-view-function 'telega-view-two-lines)
 '(telega-root-fill-column 70)
 '(telega-use-images t)
 '(tooltip-mode nil)
 '(transient-mark-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(tool-bar-mode -1)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'base16-default-dark t)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(add-to-list 'load-path "~/.emacs.d/telega.el")
(require 'telega)
(put 'set-goal-column 'disabled nil)

(setq telega-accounts (list
  (list "l" 'telega-database-dir telega-database-dir)
  (list "i" 'telega-database-dir
    (expand-file-name "i" telega-database-dir))))

(define-key global-map (kbd "C-c t") telega-prefix-map)

(setq telega-emoji-company-backend 'telega-company-emoji)

(defun my-telega-chat-mode ()
  (set (make-local-variable 'company-backends)
       (append (list telega-emoji-company-backend
                   'telega-company-username
                   'telega-company-hashtag)
             (when (telega-chat-bot-p telega-chatbuf--chat)
               '(telega-company-botcmd))))
  (company-mode 1))

(add-hook 'telega-chat-mode-hook 'my-telega-chat-mode)

(define-key tab-prefix-map "t" 'toggle-tab-bar-mode-from-frame)
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq tramp-default-method "ssh")
(setq tramp-default-user "root")
(set-frame-font "firacode 11" nil t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


(pdf-loader-install t t)
