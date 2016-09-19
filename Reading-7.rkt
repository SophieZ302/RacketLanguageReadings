;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Reading-7) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Reading Section 7 Varieties of Data
;; numbers, booleans, symbols, structures (compounds of info)
;; 7.1 Mixing and Distinguishing Data

(number? (make-posn 2 3))
(number? (+ 12 10))
(posn? 23)
(posn? (make-posn 23 3))

;; Data definition for distane-to-0
;; a pixel is either a number or a posn structure

;; stating contract purpose and header
;; distance-to-0 : pixel-2 -> number
;; to dompute the distance of a-pixel to the origin
(define (distance-to-0 a-pixel)
  (cond
    [(number? a-pixel) a-pixel]
    [(posn? a-pixel) (sqr
                      (+ (sqr (posn-x a-pixel))
                         (sqr (posn-y a-pixel))))]))


;; Data Definition:
(define-struct circle (center radius))
(define-struct square (nw length))
;; A shape is either
;; 1. a structure: (make-circle p s)
;;    where p is a posn, s a number;
;; 2. a structure: (make-square p s)
;;    where p is a posn, s a number.

;; Contract, Purpose, Header: 
;; perimeter : shape  ->  number
;; to compute the perimeter of a-shape

;; Examples: see tests

;; Template:
;; (define (f a-shape)
;;   (cond
;;     [(square? a-shape)
;;     ... (square-nw a-shape) ... (square-length a-shape) ...]
;;     [(circle? a-shape)
;;     ... (circle-center a-shape) ... (circle-radius a-shape) ...]))

;; Definition: 
(define (perimeter a-shape)
  (cond
    [(circle? a-shape)
     (* (* 2 (circle-radius a-shape)) pi)]
    [(square? a-shape)
     (* (square-length a-shape) 4)]))

;; Tests: (same as examples)
;; (= (perimeter (make-square ... 3)) 12)
;; (= (perimeter (make-circle ... 1)) (* 2 pi))