#lang racket

(require "fixed-xor.rkt")
(require "hex-utils.rkt")

(define (make-key-string n l)
  (let [(bs (make-bytes l n))]
    (apply ~a (map (λ (x) (number->string x 16))
                   (for/list [(i bs)]
                     (integer-bytes->integer (bytes i 0) #f))))))

(define c3-input "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")

(define (printable? x)
  (or (char-alphabetic? x) (char-numeric? x) (char-blank? x)))

(define (printable-percent s)
  (let [(len (string-length s))
        (count (for/sum [(i (in-string s))]
                 (if (printable? i) 1 0)))]
    (* 100.0 (/ count len))))

(for [(i (in-range 65 123))]
  (let* [(ks (make-key-string i 34))
         (key (~a (bytes i)))
         (decoded (hex->bytes ks))
         (res (~a (hex->bytes (cp-xor c3-input ks))))
         (pp (printable-percent res))]
    (displayln (~a pp " " key ": " res))))

;; pipe the output of this through 'sort -n', and the last line is:
;; "97.05882352941177 X: Cooking MC's like a pound of bacon"
;; The second-most-printable line is only 85% "printable".
