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
 '(package-selected-packages '(csharp-mode julia-mode iedit use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background unspecified))))
 '(flycheck-error ((((class color) (min-colors 257)) (:underline (:color "#BF616A" :style line))) (((class color) (min-colors 256)) (:underline (:color "#ff6655" :style line))) (((class color) (min-colors 16)) (:underline (:color "red" :style line)))))
 '(flycheck-info ((((class color) (min-colors 257)) (:underline (:color "#81A1C1" :style line))) (((class color) (min-colors 256)) (:underline (:color "#51afef" :style line))) (((class color) (min-colors 16)) (:underline (:color "brightblue" :style line)))))
 '(flycheck-warning ((((class color) (min-colors 257)) (:underline (:color "#EBCB8B" :style line))) (((class color) (min-colors 256)) (:underline (:color "#ECBE7B" :style line))) (((class color) (min-colors 16)) (:underline (:color "yellow" :style line)))))
 '(fringe ((t (:background unspecified))))
 '(helpful-heading ((t (:height unspecified))))
 '(org-block-begin-line ((t (:background unspecified :inherit shadow))))
 '(org-quote ((t (:background unspecified :inherit (font-lock-doc-face org-block)))))
 '(swiper-line-face ((t (:extend t))))
 '(vertical-border ((t (:background unspecified :inverse-video t))))
 '(which-key-command-description-face ((t (:foreground unspecified)))))
(put 'narrow-to-region 'disabled nil)
