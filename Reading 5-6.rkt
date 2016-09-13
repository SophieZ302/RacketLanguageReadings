;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Reading 5-6|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
#|Readings and Excercise of Chapter 5 9/11/2016|#
;; Section 5 Symbolic Information
;; 
;; 5.1
;; symbolic data : symbol 's string "s" image

;; Exercise 5.1.1. Evaluate (reply 'HowAreYou?) by hand and with DrScheme's stepper. Formulate a complete set of examples for reply as boolean expressions (using symbol=?).

;; Exercise 5.1.2 Develop check-guess
;; replies 'TooSmall 'Perfect 'TooLarge
;; depending on the guess and target value
;; number-> symbol
(define target 3)
(define (check-guess num)
  (cond
    [(= num target)  'Perfect]
    [(< num target)  'TooSmall]
    [(> num target)  'TooLarge]))
(check-expect (check-guess 3) 'Perfect)
(check-expect (check-guess 4) 'TooLarge)
(check-expect (check-guess 2) 'TooSmall)

;; Section 6
;; 6.1 Structures
(define (distance-to-0 a-posn) (sqrt
        (+ (sqr (posn-x a-posn))
           (sqr (posn-y a-posn)))))
(check-expect (distance-to-0 (make-posn 3 4)) 5)
;; 6.2.1
;; dimensions of traffic light
(define WIDTH 50)
(define HEIGHT 160)
(define BULB-RADIUS 20)
(define BULB-DISTANCE 10)
;; the positions of the bulbs
(define X-BULBS (quotient WIDTH 2))
(define Y-RED (+ BULB-DISTANCE BULB-RADIUS))
(define Y-YELLOW (+ Y-RED BULB-DISTANCE (* 2 BULB-RADIUS)))
(define Y-GREEN (+ Y-YELLOW BULB-DISTANCE (* 2 BULB-RADIUS)))
;; draw the light with the red bulb turned on
(start WIDTH HEIGHT)
(draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
(draw-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)
(draw-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)