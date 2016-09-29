;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lec3-2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; lec3 Part2 Self-Referential Data Definition
;; Russian Doll
(define-struct doll (contents))
;; A RD is one of:
;; - "solid"
;; - (make-doll "solid")
;; - (make-doll (make-doll "solid"))
;; - (make-doll (make-doll (make-doll "solid")))
;; ....

(define r1 "solid")
(define r2 (make-doll "solid"))
(define r3 (make-doll (make-doll "solid")))
(define r4 (make-doll (make-doll (make-doll "solid"))))

;; A RD is one off
;; - "solid"
;; - (make-doll RD)
;; for templates ask conditions? break-apart? self-reference?
#|(define (rd-temp ard)
  (cond [(string? ard) ...]
        [(doll? ard) (rd-temp (doll-contents ard))]))|#

;; RD -> Number
;; conts the number of shells of the doll
;; test
;(check-expect (count-shell r1) 0);
;(check-expect (count-shell r2) 1);
;;(check-expect (count-shell r4) 3);

(define (count-shell ard)
  (cond [(string? ard) 0] ;; base case
        [(doll? ard) (+ 1 (count-shell (doll-contents ard)))]))



;; ice-cream cone with different scoops
;; Data Definition
;; A ICC is one of:
;; - "cone"
;; - (make-icecream String ICC)
(define-struct icecream (flavor base))


(define icc1 "cone")
(define icc2 (make-icecream "Chocolate" icc1))
(define icc3 (make-icecream "Vanilla" icc2))
(define icc4 "Strawberry")

;; check to see if there is chocolate in the icecream
;; ICC ->BOOL
;; test
;;(check-expect (chocolate? icc1) #false)
(check-expect (chocolate? icc2) #true)
;;(check-expect (chocolate? icc4) #false)

(define (chocolate? i)
  (cond [(string? i) (string=? i "Chocolate")]
        [(icecream? i) (chocolate? (icecream-base i))]))




