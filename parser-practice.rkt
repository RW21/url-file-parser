#lang racket

(require megaparsack megaparsack/text)
(require data/monad)
(require data/functor)
(require data/applicative)

(define io*/p
  (do (char/p #\i)
      (char/p #\o)
      (pure "sucecss!")))

(parse-string io*/p "iooio")

(define true/p
  (do (string/p "true")
      (pure #t)))

(define false/p
  (do (string/p "false")
      (pure #f)))

(define boolean/p
  (or/p true/p false/p))

(define the-labeled-integer/p
  (do (string/p "the integer: ")
      integer/p))

(define the-labeled-boolean/p
  (do (string/p "the boolean: ")
      boolean/p))

(parse-string (many/p (string/p "hello ")) "hello hello ")

(define two-integers/p
  (do (many/p space/p #:min 1)
      [x <- integer/p]
      (many/p space/p #:min 1)
    [y <- integer/p]
    (many/p space/p #:min 1)
    (pure (list x y))))

(parse-string two-integers/p "123 222")

(parser? (string/p "hi"))
(parser? (or/p (string/p "hi") (string/p "bye")))

      
