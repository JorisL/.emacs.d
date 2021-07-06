;;; ol-browse-url.el - Support for links to man pages in Org mode
;;; Author: Joris Laurenssen
(require 'ol)

(org-link-set-parameters "browse-url"
                         :follow #'org-browse-url-open
                         :store #'org-browse-url-store-link)

(defun org-browse-url-open (path _)
  "Visit the manpage on PATH.
PATH should be a topic that can be thrown at the man command."
  (browse-url path))

(defun org-browse-url-export (link description format _)
  "Export a man page link from Org files."
  (let ((desc (or description link)))
    (pcase format
      (`html (format "<a target=\"_blank\" href=\"%s\">%s</a>" link desc))
      (`latex (format "\\href{%s}{%s}" link desc))
      (`texinfo (format "@uref{%s,%s}" link desc))
      (`ascii (format "%s (%s)" link path))
      (_ link))))

(provide 'ol-browse-url)
;;; ol-browse-url.el ends here
