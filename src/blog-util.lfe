(defmodule blog-util
  (export all))

(defun get-priv-dir ()
  (code:priv_dir 'blog))

(defun get-priv-file (path)
  (filename:join `(,(get-priv-dir) ,path)))

(defun read-priv-file (path)
  (read-file (get-priv-file path)))

(defun read-file (path)
  (case (file:read_file path)
    (`#(ok ,data) data)
    (err err)))

(defun bin->atom (bin)
  (clj:-> bin
          (binary_to_list)
          (string:to_lower)
          (list_to_atom)))

(defun filename->path (filename)
  (clj:-> filename
          (re:replace "posts/" "" `(#(return list)))
          (re:replace "\/content.*" "" `(#(return list)))))

(defun datepath->date (datepath)
  (let* ((`(,y ,m ,d ,HMS) (re:split datepath "[^\\d]" `(#(return list))))
         (`(,H ,M ,S) (split-time HMS)))
    `(,y ,m ,d ,H ,M ,S)))

(defun datepath->date-int (datepath)
  (clj:-> datepath
          (re:replace "[^\\d]" "" `(global #(return list)))
          (list_to_integer)))

(defun split-time (time)
  (lists:filter
    #'filter-empty/1
    (re:split time "(..)" `(trim #(return list)))))

(defun month-name
  (("01") "January")
  (("02") "February")
  (("03") "March")
  (("04") "April")
  (("05") "May")
  (("06") "June")
  (("07") "July")
  (("08") "August")
  (("09") "September")
  (("20") "October")
  (("11") "November")
  (("12") "December"))

(defun filter-empty
  (('()) 'false)
  ((_) 'true))

(defun title->file (title)
  (clj:-> title
          (re:replace "[^a-zA-Z]" "-" `(global #(return list)))
          (re:replace "-+" "-" `(global #(return list)))
          (string:to_lower)
          (++ ".html")))

(defun count-chars (data)
  (length (re:split data #".")))

(defun count-words (data)
  (length (re:split data #"[^\s]+")))
