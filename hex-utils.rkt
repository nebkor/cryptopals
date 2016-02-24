#lang racket

(provide hex->bytes hex->base64)

(require net/base64)

(define (hex->bytes s)
  (define (iter sl r)
    (cond
     [(null? sl) (list->bytes (reverse r))]
     [(= 1 (length sl)) (iter '() (cons (string->number (~a (car sl)) 16) r))]
     [else
      (let* [(f (car sl))
             (s (cadr sl))
             (b (~a f s))
             (bb (string->number b 16))
             (rest (cddr sl))]
        (iter rest (cons bb r)))]))
  (iter (string->list s) '()))

(define (hex->base64 s)
  (base64-encode (hex->bytes s) #""))
