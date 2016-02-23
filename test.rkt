#lang racket

(require "hex-utils.rkt")

(module+ test
  (require rackunit rackunit/text-ui)

       (define base64-string #"SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")
     (define hex-string "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d")
     (define byte-string #"I'm killing your brain like a poisonous mushroom")

  (define suite
    (test-suite
     "hex tests"


     (test-equal? "base64"
                  (hex->base64 hex-string)
                  base64-string)

     (test-equal? "ascii to bytes"
                  (hex->bytes hex-string)
                  byte-string)

))

  (run-tests suite))
