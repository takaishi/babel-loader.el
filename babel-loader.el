(require 'init-loader)
(require 'ob)

(defun bl:get-file-modified (file)
  (let* ((modified (nth 5 (file-attributes file)))
		 (high (nth 1 modified))
		 (low (nth 2 modified)))
	(+ (* high 65536) low)))

(defun bl:config-updated-p (file)
  (let* ((base-name (file-name-sans-extension file))
		 (exported-file (concat base-name ".el")))
	(and (file-exists-p exported-file)
		 (> (bl:get-file-modified file)
			(bl:get-file-modified exported-file)))))
  
(defun bl:compile (file exported-file)
  (if (bl:config-updated-p file)
      (org-babel-tangle-file file
			     exported-file
			     "emacs-lisp")))

(defun bl:compile-dir (dir)
  (mapc #'(lambda (file)
			(let* ((base-name (file-name-sans-extension file))
				   (exported-file (concat base-name ".elq")))
			  (bl:compile file exported-file)))
		(directory-files dir t "\\.org$")))

(defun bl:load-dir (dir)
  (bl:compile-dir dir)
  (init-loader-load dir))

(provide 'babel-loader)
