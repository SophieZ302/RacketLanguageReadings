;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Lab_lec2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))

;; Data definition = itemization
;; An Item is on of:
;; -- Number
;; -- Boolean
;; (make-posn Number Number)

;; template
;; step 1 how many classes of data, if more than 1, use cond
;; step 2 how to distinguish
;; step 3 any structures to break apart
(define (item-temp an-item)
  (cond [(number? an-item)  ... ]
        [(boolean? an-item) ... ]
        [(posn? an-item)
         ... (posn-x an-item) ...
         ... (posn-y an-item) ...]))