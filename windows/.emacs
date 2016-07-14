;;
;; .emacs, Ryan James Spencer
;;

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
    'package-archives
    '("melpa" . "http://melpa.org/packages/")
    t)
  (package-initialize))

;; Credit to Aaron Bieber for this.
(defun ensure-package-installed (&rest packages)
  "Installs all uninstalled packages "
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (package-install package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun kill-other-buffers-and-windows ()
  "Kill all buffers and windows except the currently selected."
  (interactive)
  (mapc 'kill-buffer (delq '(current-buffer *scratch*) (buffer-list)))
  (delete-other-windows))

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 132))

(ensure-package-installed 'evil         ;; Essential
                          'evil-escape
                          'evil-magit
                          'evil-surround
                          'evil-ediff
                          'evil-org
                          'evil-paredit

                          'zenburn-theme
                          'base16-theme
                          'rainbow-delimiters
                          'rainbow-mode
                          'smart-mode-line

                          'ace-window   ;; Productivity
                          'bind-key
                          'company
                          'free-keys
                          'git-timemachine
                          'helm
                          'hl-todo
                          'magit
                          'multi-term
                          'ediff
                          'ssh
                          'latex-preview-pane

                          'aggressive-indent ;; Programming
                          'cider
                          'clj-refactor
                          'clojure-cheatsheet
                          'cmake-mode
                          'elixir-mode
                          'erlang
                          'go-mode
                          'haskell-mode
                          'inf-ruby
                          'markdown-preview-mode
                          'php-mode
                          'rust-mode
                          'scala-mode2
                          'slime
                          'tuareg
                          'typescript-mode
                          'gitconfig-mode
                          'json-mode
                          'web-mode

                          '2048-game    ;; Games
                          'chess
                          'ducpel
                          'gnugo
                          'poker
                          'sokoban
                          )

(blink-cursor-mode 0)

(require 'bind-key)
(bind-key "C-c 1" 'kill-other-buffers-and-windows)

(require 'hl-todo)
(global-hl-todo-mode t)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'cider)
(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(setq cider-repl-display-help-banner nil)
(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'paredit-mode)

;; Make reloading .emacs changes easier
(defun reload-emacs ()
  (interactive)
  (load-file "~/.emacs"))
(bind-key "C-x r e" 'reload-emacs)

;; Setup keybind for magit-status
(require 'magit)
(bind-key "C-c g" 'magit-status)

;; Set default font
(add-to-list 'default-frame-alist '(font . "Fira Mono-11"))
(set-face-attribute 'default t :font "Fira Mono-11")

;; Cleanup whitespace on every save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Show the time
(display-time-mode t)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(require 'multi-term)
(setq multi-term-program "/bin/bash")
(bind-key "C-x t" 'eshell)

;; Smoother window transitions
(require 'ace-window)
(bind-key "<C-tab>" 'ace-window)

(require 'cider)
(setq cider-show-error-buffer nil)

;; go-mode gofmt before save
(add-hook 'before-save-hook #'gofmt-before-save)

;; Don't let ido steal focus when trying to create dirs/files
(setq ido-auto-merge-work-directories-length -1)

;; Slime REPL
(setq inferior-lisp-program (executable-find "sbcl"))

;; Prevent line wrapping
(set-default 'truncate-lines t)
;; Toggle word wrapping for long lines
(bind-key "C-'" 'visual-line-mode)

;; For helpful configuration
(bind-key "C-h C-k" 'free-keys)

(bind-key "C-M-;" 'align-regexp)

;; Get rid of that ugly welcome message.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Highlight matching parens
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; Only spaces
(setq-default indent-tabs-mode nil)

;; Remove nuisances
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Tell which column point is on
(column-number-mode t)

(require 'evil)
(evil-mode t)

(require 'evil-paredit)
(add-hook 'paredit-mode-hook #'evil-paredit-mode)

;; Make evil-mode omnipresent
(evil-set-initial-state 'info-mode 'normal)
(setq evil-normal-state-modes (append evil-motion-state-modes evil-normal-state-modes))
(setq evil-motion-state-modes nil)

;; Make evil keybindings work in git-timemachine
;; see http://blog.binchen.org/posts/use-git-timemachine-with-evil.html
(require 'git-timemachine)
(eval-after-load 'git-timemachine
  '(progn
     (evil-make-overriding-map git-timemachine-mode-map 'normal)
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))

(require 'evil-surround)
(global-evil-surround-mode t)

(require 'evil-escape)
(evil-escape-mode t)

;; Co-map escape key for evil-modes
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)

;; Make '?' search backwards instead of bringing up help
(require 'evil-magit)
(evil-define-key evil-magit-state magit-mode-map "?" 'evil-search-backward)

;; Easily resize windows in a frame.
(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

(require 'rainbow-delimiters)
(add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
;; (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Ido niceties
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;; Indent switch statements normally
(c-set-offset 'case-label '+)

;; Avy keybindings
(bind-key "M-g g" 'avy-goto-line)
(bind-key "M-g c" 'avy-goto-char)

;; Follow url link at point
(bind-key "C-&" 'browse-url-at-point)

(require 'smart-mode-line)
(setq sml/theme 'respectful)
(add-hook 'after-init-hook 'sml/setup)

;; Taken from
;; https://emacs.wordpress.com/2007/01/17/eval-and-replace-anywhere/
(defun fc-eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(bind-key "C-c e" 'fc-eval-and-replace)

(setq tramp-default-method "ssh")

(require 'aggressive-indent)
(add-hook 'clojure-mode-hook #'aggressive-indent-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (base16-ocean-dark)))
 '(custom-safe-themes
   (quote
    ("50e7f9d112e821e42bd2b8410d50de966c35c7434dec12ddea99cb05dd368dd8" "e24679edfdea016519c0e2d4a5e57157a11f928b7ef4361d00c23a7fe54b8e01" "f3d6a49e3f4491373028eda655231ec371d79d6d2a628f08d5aa38739340540b" "20e359ef1818a838aff271a72f0f689f5551a27704bf1c9469a5c2657b417e6c" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(package-selected-packages
   (quote
    (company-go base16-theme zenburn-theme web-mode typescript-mode tuareg ssh sokoban smart-mode-line slime scala-mode2 rust-mode rainbow-mode rainbow-delimiters poker php-mode multi-term markdown-preview-mode latex-preview-pane json-mode inf-ruby hl-todo haskell-mode go-mode gnugo gitconfig-mode git-timemachine ggtags free-keys evil-surround evil-paredit evil-org evil-magit evil-escape evil-ediff erlang elixir-mode ducpel company cmake-mode clojure-cheatsheet clj-refactor chess bind-key aggressive-indent ace-window 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )