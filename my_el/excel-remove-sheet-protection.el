;;; excel-remove-sheet-protection.el - Remove sheet protection from an Excel xlsx file.
;;; Author: Joris Laurenssen
;; 
;; Within Excel it is possible to "protect" a sheet with a password to make it "impossible" to edit the sheet and/or view cell formula's.
;; However; this information is still available without password, since excel should be able to still calculate using those formulas.
;; This protection is done by adding a "sheetprotection" tag with a SHA-512 hash in the xml file describing the sheet within the xlsx file.
;; When this tag is in the file, excel (or libreoffice for that matter) will ask for the password, and if the passwords SHA-512 hash doesnt match it will not unlock the sheet.
;; The rest of the xml file is practically unchanged by enabling this tag, so if we can remove the tag we can remove the password protection :D
;; 
;; Whilst it would theoretically be possible to unzip the complete excel file, edit the files normally, and re-zip the folder,
;; that doesn't practically work (possibly due to excel files having different/no compression as compared to a normal zip-folder).
;; But thanks emacs for being able to edit files directly within zip files, which doesn't alter those settings :)
;; 
;; This function queries for an excel file, and removes the "sheetprotection" tag within each of the sheet xml files.
;; 
;; Note: gnu zip and unzip have to be installed, since the xlsx files are read as zip-files.
;; Note 2: this could probably be done easier/cleaner by directly opening the embedded XML files using TRAMP's zip support,
;;   but that doesn't work on Windows.

(defun excel-remove-sheet-protection ()
  "Remove sheet protection from an Excel xlsx file."
  (interactive)
  (find-file (read-file-name "Enter xlsx file path/name: "))  ;open excel file as zip-folder
  (beginning-of-buffer)
  (while (condition-case nil              ;try to do this for all sheets
             (search-forward-regexp "xl/worksheets/sheet.*?\.xml")
           (error nil))                    ;try to move cursor to next sheet.xml
    (let ((current_xml_point (point)))    ;store the current sheet
      ;; open the sheet and remove the "sheetprotection" xml tag
      (archive-extract)
      (beginning-of-buffer)
      (while (re-search-forward "<sheetprotection.*?>" nil t)
        (replace-match ""))
      (save-buffer)
      (kill-buffer)
      (goto-char current_xml_point))))     ;put cursor at last sheet
;;; excel-remove-sheet-protection.el ends here
