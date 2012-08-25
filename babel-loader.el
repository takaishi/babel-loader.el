(require 'init-loader)
(require 'ob)

(defun bl:compile (file exported-file)
  (org-babel-tangle-file file
						 exported-file
						 "emacs-lisp"))

