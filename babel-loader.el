(require 'init-loader)
(require 'ob)

(defun bl:compile (file exported-file)
  (org-babel-tangle-file file
						 exported-file
						 "emacs-lisp"))

(defun bl:compile-dir (dir)
  (mapc #'(lambda (file)
			(let* ((base-name (file-name-sans-extension file))
				   (exported-file (concat base-name ".el")))
			  (bl:compile file exported-file)))
		(directory-files dir t "\\.org$")))
