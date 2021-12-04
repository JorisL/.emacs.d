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
 '(custom-safe-themes
   '("4b0e826f58b39e2ce2829fab8ca999bcdc076dec35187bf4e9a4b938cb5771dc" "80147cd7121944101fb451c69800c8565db80b5b819754118d96a28be6ea1054" "835868dcd17131ba8b9619d14c67c127aa18b90a82438c8613586331129dda63" "b0e446b48d03c5053af28908168262c3e5335dcad3317215d9fdeb8bac5bacf9" "1704976a1797342a1b4ea7a75bdbb3be1569f4619134341bd5a4c1cfb16abad4" "b0334e8e314ea69f745eabbb5c1817a173f5e9715493d63b592a8dc9c19a4de6" default))
 '(exwm-floating-border-color "#1c2028")
 '(highlight-tail-colors ((("#394147") . 0) (("#37424e") . 20)))
 '(jdee-db-active-breakpoint-face-colors (cons "#191C25" "#81A1C1"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#191C25" "#A3BE8C"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#191C25" "#434C5E"))
 '(objed-cursor-color "#BF616A")
 '(package-selected-packages
   '(htmlize paredit aggressive-indent smartparens adjust-parens soothe-theme zoom golden-ratio csharp-mode julia-mode iedit use-package))
 '(pdf-view-midnight-colors (cons "#ECEFF4" "#2E3440"))
 '(rustic-ansi-faces
   ["#2E3440" "#BF616A" "#A3BE8C" "#EBCB8B" "#81A1C1" "#B48EAD" "#88C0D0" "#ECEFF4"])
 '(vc-annotate-background "#2E3440")
 '(vc-annotate-color-map
   (list
    (cons 20 "#A3BE8C")
    (cons 40 "#bbc28b")
    (cons 60 "#d3c68b")
    (cons 80 "#EBCB8B")
    (cons 100 "#e2b482")
    (cons 120 "#d99d79")
    (cons 140 "#D08770")
    (cons 160 "#c68984")
    (cons 180 "#bd8b98")
    (cons 200 "#B48EAD")
    (cons 220 "#b77f96")
    (cons 240 "#bb7080")
    (cons 260 "#BF616A")
    (cons 280 "#a05b67")
    (cons 300 "#815664")
    (cons 320 "#625161")
    (cons 340 "#4C566A")
    (cons 360 "#4C566A")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-bar ((t (:background unspecified))))
 '(flycheck-error ((((class color) (min-colors 257)) (:underline (:color "#CC6666" :style line))) (((class color) (min-colors 256)) (:underline (:color "#CC6666" :style line))) (((class color) (min-colors 16)) (:underline (:color "red" :style line)))))
 '(flycheck-info ((((class color) (min-colors 257)) (:underline (:color "#FCFCFA" :style line))) (((class color) (min-colors 256)) (:underline (:color "#FCFCFA" :style line))) (((class color) (min-colors 16)) (:underline (:color "white" :style line)))))
 '(flycheck-warning ((((class color) (min-colors 257)) (:underline (:color "#FFD866" :style line))) (((class color) (min-colors 256)) (:underline (:color "#FFD866" :style line))) (((class color) (min-colors 16)) (:underline (:color "yellow" :style line)))))
 '(fringe ((t (:background unspecified))))
 '(helpful-heading ((t (:height unspecified))))
 '(org-block-begin-line ((t (:background unspecified :inherit shadow))))
 '(org-quote ((t (:background unspecified :inherit (font-lock-doc-face org-block)))))
 '(swiper-line-face ((t (:extend t))))
 '(vertical-border ((t (:background unspecified :inverse-video t))))
 '(which-key-command-description-face ((t (:foreground unspecified)))))
(put 'narrow-to-region 'disabled nil)
