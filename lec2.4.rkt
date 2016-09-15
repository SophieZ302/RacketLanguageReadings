;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lec2.4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; lec2.4

;; data definition reflect what is changing

;; A TL (Traffic Light) is one of:
;; - "red"
;; - "yellow"
;; - "green"

;; TL -> TL
;; launches the traffic light animation
(define (main atl)
  (big-bang atl
            (to-draw draw-light)
            (on-tick change-light 0.3)))

;; Template, only deal with input
#|
(define (tl-temp atl)
  (cond [string=? alt "red" ...]
        [string=? alt "yellow" ...]
        [string=? alt "green"...]))
|#

;; draw-light
;; 1. data definition
(define RADIUS 50)
;; 2. signature
;; TL -> image
;; draws the traffic light
;; 3. Test
;; must have at least three test for each of the option
(check-expect (draw-light "red") (circle RADIUS "solid" "red"))
(check-expect (draw-light "green") (circle RADIUS "solid" "green"))
(check-expect (draw-light "yellow") (circle RADIUS "solid" "yellow"))

(define (draw-light atl)
  (circle RADIUS "solid" atl))

;; change-light
;; TL -> TL
;; changes the traffic light color
(check-expect (change-light "red") "green")
(check-expect (change-light "green") "yellow")
(check-expect (change-light "yellow")  "red")

(define (change-light atl)
  (cond [(string=? atl "red") "green"]
        [(string=? atl "yellow") "red"]
        [(string=? atl "green") "yellow"]))

(main "green")