(defmodule blog-data
  (export all))

(defun base (title)
  `(#(site_title ,(blog-cfg:site-title))
    #(site_description ,(blog-cfg:site-description))
    #(page_title ,title)
    #(index "index")
    #(landing "landing")
    #(archives "archives")
    #(categories "categories")
    #(tag "tags")
    #(authors "authors")
    #(about "about")
    #(design "design")))
