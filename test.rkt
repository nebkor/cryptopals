#lang racket

(require "hex-utils.rkt")
(require "fixed-xor.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

  ;; challenge 1
  (define base64-string #"SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")
  (define hex-string "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
  (define c1-byte-string #"I'm killing your brain like a poisonous mushroom")

  ;; challenge 2
  (define c2-input "1c0111001f010100061a024b53535009181c")
  (define c2-test-val "686974207468652062756c6c277320657965")
  (define c2-output "746865206b696420646f6e277420706c6179")
  (define c2-out-decoded #"the kid don't play")

  (define suite
    (test-suite
     "challenges"

     ;; challenge 1
     (test-equal? "base64"
                  (hex->base64 hex-string)
                  base64-string)

     (test-equal? "ascii to bytes"
                  (hex->bytes hex-string)
                  c1-byte-string)

     (test-equal? "kid don't play"
                  (hex->bytes c2-output)
                  c2-out-decoded)

     ;; challenge 2
     (test-equal? "xor"
                  (cp-xor c2-input c2-test-val)
                  c2-output)))

  (run-tests suite))
