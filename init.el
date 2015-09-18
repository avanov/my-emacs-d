(add-to-list 'load-path
             (file-name-as-directory "~/.emacs.d/elisp/"))
(load-library "style")
(load-library "keys")
(load-library "modes")

;; add custom color themes dir from
;; https://github.com/emacs-jp/replace-colorthemes
(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/replace-colorthemes/"))

;; encoding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;; no tabs
(setq-default indent-tabs-mode nil)
(setq tab-stop-list (number-sequence 4 120 4))

;; built-in plugins
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

;; buffer show
(require 'bs)
(global-set-key (kbd "<f2>") 'bs-show)

;; line numbers from the left
(global-linum-mode t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(coffee-tab-width 4)
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (taylor)))
 '(custom-safe-themes (quote ("5cd698ce53179b1e4eaa7917c992832a220600c973967904fea71e3980a46532" "234249a92c2cf7b61223d9f83e1d9eefcd80fcf6b7a5e9ca03dc9d3f1b122ae2" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(fci-rule-color "#eee8d5")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors (--map (solarized-color-blend it "#fdf6e3" 0.25) (quote ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors (quote (("#eee8d5" . 0) ("#B4C342" . 20) ("#69CABF" . 30) ("#69B7F0" . 50) ("#DEB542" . 60) ("#F2804F" . 70) ("#F771AC" . 85) ("#eee8d5" . 100))))
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#dc322f") (40 . "#c85d17") (60 . "#be730b") (80 . "#b58900") (100 . "#a58e00") (120 . "#9d9100") (140 . "#959300") (160 . "#8d9600") (180 . "#859900") (200 . "#669b32") (220 . "#579d4c") (240 . "#489e65") (260 . "#399f7e") (280 . "#2aa198") (300 . "#2898af") (320 . "#2793ba") (340 . "#268fc6") (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list (quote (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))


(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

  ;; powerline mode-line
  ;;(require 'powerline)
  ;;(powerline-default-theme)

  ;; Simple auto-installation of packages for reproducible environments
  ;; ------------------------------------------------------------------
  (defvar local-packages '(projectile
                           auto-complete
                           yasnippet
                           epc
                           jedi
                           ))

  (defun non-installed-packages (packages)
    (delq nil
          (mapcar (lambda (p)
                    (if (package-installed-p p nil) nil p))
                  packages)))

  (let ((need-to-install
         (non-installed-packages local-packages)))
    (when need-to-install
      (progn 
        (package-refresh-contents)
        (dolist (p need-to-install)
          (package-install p)))))


  ;; ---------------------------------------------------------

  )


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


;; maximized window mode
(defun toggle-fullscreen ()
  (interactive)
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
)
(when (eq window-system 'x)
  (toggle-fullscreen)
)


;; Tuareg mode file masks
(setq auto-mode-alist 
  (append '(("\\.ml[ily]?$" . tuareg-mode)
            ("\\.eliom$" . tuareg-mode)
            ("\\.topml$" . tuareg-mode))
            auto-mode-alist))


;; Auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Projectile
(require 'projectile)
(projectile-global-mode)


;; Restore opened buffers on each session
;; --------------------------------------
;; use only one desktop
(setq desktop-path '("~/.emacs.d/"))
(setq desktop-dirname "~/.emacs.d/")
(setq desktop-base-file-name "emacs-desktop")
(desktop-save-mode 1)
