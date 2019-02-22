;;----------------------------------------------------------------------------
;; Bootstrap
;;----------------------------------------------------------------------------

;; Load package manager
(require 'package)

;; Add package repositories
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

;; Avoid loading the packages again after processing the init file
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Package-Installation.html
(setq package-enable-at-startup nil)
(package-initialize)

;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; Embrace Vim
(use-package evil
  :ensure t
  :config
  (evil-mode t))

;;----------------------------------------------------------------------------
;; Look and feel
;;----------------------------------------------------------------------------

(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; Add theme
(use-package monokai-theme
  :ensure t
  :config
  (load-theme 'monokai t))

(use-package mode-icons
  :ensure t
  :config
  (mode-icons-mode))

(use-package spaceline-config
  :ensure spaceline
  :init
  (setq powerline-default-separator 'wave
        spaceline-workspace-numbers-unicode t
        spaceline-window-numbers-unicode t
        spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  :config
  (spaceline-spacemacs-theme)
  (spaceline-helm-mode)
  (spaceline-info-mode))

;; Display whitespace characters
(use-package whitespace
  :ensure t
  :init
  (setq whitespace-style
    '(face
      empty
      trailing
      lines-tail
      tabs
      spaces))
  :config
  (global-whitespace-mode))

;; Column 80
(setq-default fill-column 80)
(use-package fill-column-indicator
  :ensure t
  :init
  (setq
    fci-rule-width 5
    fci-rule-color "#3c3d37")
  (add-hook 'after-change-major-mode-hook 'fci-mode))

;; Relative line numbers
(use-package linum-relative
  :ensure t
  :init (setq display-line-numbers-type "relative")
  :config
  (linum-relative-on)
  (global-linum-mode))

;;----------------------------------------------------------------------------
;; Utilities
;;----------------------------------------------------------------------------

;; Auto-complete utility
(use-package helm
  :ensure t
  :init
  (setq
    helm-autoresize-mode t
    helm-buffers-fuzzy-matching t)
  :bind
  (("M-x" . helm-M-x)
   ("C-x C-f" . helm-find-files)
   ("C-x C-b" . helm-buffers-list))
  :config
  (helm-mode t))

;; Icons used in neotree
(use-package all-the-icons
  :ensure t)

;; File tree drawer
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  :bind (("<f8>" . neotree-toggle))
  :config
  (evil-set-initial-state 'neotree-mode 'normal)
  (evil-define-key 'normal neotree-mode-map
    (kbd "RET") 'neotree-enter
    (kbd "g")   'neotree-refresh
    (kbd "C")   'neotree-change-root
    (kbd "I")   'neotree-hidden-file-toggle
    (kbd "q")   'neotree-hide))

(use-package magit
  :ensure t)

;;----------------------------------------------------------------------------
;; Software development
;;----------------------------------------------------------------------------

(use-package drupal-mode
  :ensure t)

(use-package php-mode
  :ensure t
  :mode ("\\.php\\'" . php-mode))
