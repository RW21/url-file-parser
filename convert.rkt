#lang racket

(require "url-parser.rkt")
(require racket/path)

(define dir (directory-list))

(define output-file-name "links.txt")

(cond
  [(member (string->path output-file-name) dir)
   (begin ((display (~a output-file-name " already exists in directory"))
           (exit)))])

;open file for working
(define out (open-output-file "links.txt" #:exists 'can-update))

(define (extract-url s)
  (hash-ref 
   (url-file-parser s)
   "URL"))

(for/list ([file dir])
  (cond
    [(equal? (path-get-extension file) #".url")
  (begin (display (extract-url
                   (file->string file)) out)
  (display #\newline out))]))
             
(close-output-port out)
    
