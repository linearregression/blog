(defmodule blog-routes
  (export all))

(defun site ()
  "Generate the blog site."
  (poise:site
    (routes)
    `#m(output-dir ,(blog-cfg:output-dir))))

(defun routes ()
  (let ((data (blog:process)))
    (lists:append
      (static-routes data)
      (posts-routes data))))

(defun static-routes (data)
  `(("index.html" ,#'blog-pages:landing/0)
    ("archives.html" ,#'blog-pages:archives/0)
    ("categories.html" ,#'blog-pages:categories/0)
    ("tags.html" ,#'blog-pages:tags/0)
    ("authors.html" ,#'blog-pages:authors/0)
    ("pages.html" ,#'blog-pages:pages/0)
    ("about.html" ,#'blog-pages:about/0)
    ("starship-timeline.html" ,#'blog-pages:timeline/0)
    ("search.html" ,#'blog-pages:search/0)
    ("design.html" ,#'blog-pages:design/0)
    ("design/bootstrap-theme.html" ,#'blog-pages:bootstrap-theme/0)
    ("design/example-1-column.html" ,#'blog-pages:example-one-column/0)
    ("design/example-2-column.html" ,#'blog-pages:example-two-column/0)))

(defun posts-routes (posts)
  (lists:map #'get-route/1 posts))

(defun get-route (post-data)
  `(,(proplists:get_value 'dst-file post-data) ,#'blog-pages:about/0))
