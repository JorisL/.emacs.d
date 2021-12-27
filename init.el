; this is a bare init file which loads the rest of the configuration from dotemacs.org

(let ((default-directory user-emacs-directory)
      (file-name-handler-alist nil)
      (gc-cons-percentage .6)
      (gc-cons-threshold most-positive-fixnum)
      (read-process-output-max (* 1024 1024)))

  ;; Disable that pesky echo message
  (setq-default inhibit-startup-echo-area-message (user-login-name))

  ;; Set repositories
  (require 'package)
  (setq-default
   load-prefer-newer t
   package-enable-at-startup nil)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
  (add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
  (package-initialize)

  ;; Install `use-package' dependency by hand
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package t))
  (setq-default
   package-native-compile t
   use-package-always-defer t
   use-package-always-ensure t)

  ;; Tangle configuration
  (org-babel-load-file (expand-file-name "dotemacs.org" user-emacs-directory) t)
  (garbage-collect))

;; Reset the working directory regardless of where Emacs was started
(cd "~/")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(modus-themes fancy-dabbrev python-black orderless cape corfu lispy exec-path-from-shell ht embark avy htmlize paredit aggressive-indent smartparens adjust-parens soothe-theme zoom golden-ratio csharp-mode julia-mode iedit use-package)))
