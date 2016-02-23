#lang racket

(provide hex->bytes hex->base64)

(require net/base64)

;; 49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d
;; should produce
;; SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t

;;(define hstring "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d") ;; "I'm killing your brain like a poisonous mushroom"

(define (hex->bytes s)
  (define (iter sl r)
    (if (null? sl)
        (list->bytes (reverse r))
        (let* [(f (car sl))
               (s (cadr sl))
               (b (~a f s))
               (bb (string->number b 16))
               (rest (cddr sl))]
          (iter rest (cons bb r)))))
  (iter (string->list s) '()))

(define (hex->base64 s)
  (base64-encode (hex->bytes s) #""))
