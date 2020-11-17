#lang racket

(require megaparsack megaparsack/text)
(require data/monad)
(require data/functor)
(require data/applicative)

(provide url-file-parser)

(define chars/p
  (many/p any-char/p))

(define newline/p
  (or/p
   (do
       (char/p #\return)
       (char/p #\newline))
   (char/p #\newline)
   (char/p #\return)))

(define item/p
  (do  [key <- (or/p
       (string/p "URL")
       (string/p "WorkingDirectory")
       (string/p "ShowCommand")
       (string/p "IconIndex")
       (string/p "IconFile")
       (string/p "Modified")
       (string/p "HotKey"))]
      (char/p #\=)
      [val <- chars/p]
    (or/p newline/p
          void/p)
    (pure (list key (list->string val)))
    ))

(define url/p
  (do
      (or/p newline/p
            void/p)
    (string/p "[InternetShortcut]")
      (or/p newline/p
            void/p)
    (many/p item/p)
    ))


(define (url-file-parser s)
  (apply hash
         (flatten (parse-result! (parse-string url/p s)))))
