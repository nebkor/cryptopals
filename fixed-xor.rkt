#lang racket

(provide cp-xor)

(require "hex-utils.rkt")

(define (cp-xor s1 s2)
  (let [(bs1 (hex->bytes s1))
        (bs2 (hex->bytes s2))]
    (apply ~a (map (λ (x) (number->string x 16))
                   (for/list [(i bs1)
                              (j bs2)]
                     (bitwise-xor i j))))))
