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

;; Section 6 Compound Data
;; 6.1 Structures

;; distance-to-0 : posn  ->  number
;; to compute the distance of a-posn to the origin 
(define (distance-to-0 a-posn)
  (sqrt(+
   (* (posn-x a-posn) (posn-x a-posn))
   (* (posn-y a-posn) (posn-y a-posn)))))
(check-within (distance-to-0 (make-posn 3 4)) 5 0.001)
(check-within (distance-to-0 (make-posn (* 2 3) (* 2 4))) 10 0.001)
(check-within (distance-to-0 (make-posn 12 (- 6 1))) 13 0.001)

;; 6.2 Extended Excercise: Drawing Simple Pictures
(require 2htdp/image)
(require htdp/draw)
;(start 300 300)
;(draw-solid-line (make-posn 10 10) (make-posn 110 10) 'red)
;(draw-solid-rect (make-posn 10 30) 100 50 'blue)
;(draw-circle (make-posn 110 30) 30 'yellow)
;(draw-solid-disk (make-posn 10 80) 50 'green)
;(stop)

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
; -------------------------------------------------------------------------
;; Excercise 6.2.2 
;; clear-bulb: symbol ->true
;; clear one of the bulb
(define (clear-bulb color)
  (cond
    [(symbol=? 'red    color)  
     (and (clear-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
          (draw-circle (make-posn X-BULBS Y-RED) BULB-RADIUS 'red))]
    [(symbol=? 'green  color) 
     (and (clear-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)
          (draw-circle (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green))]
    [(symbol=? 'yellow color) 
      (and (clear-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'green)
          (draw-circle (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'green))]
    [else #false]
    )
  )
;; Excercise 6.2.3
;; draw-bulb: symbol ->true 
;; turn on traffic light
(define (reset-light one)
  (and
   (clear-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)
   (clear-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)
   (clear-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)))
(define (red-on one)
  (and (reset-light 1)
   (draw-solid-disk (make-posn X-BULBS Y-RED) BULB-RADIUS 'red)))
(define (yellow-on one)
  (and (reset-light 1)
  (draw-solid-disk (make-posn X-BULBS Y-YELLOW) BULB-RADIUS 'yellow)))
(define (green-on one)
  (and (reset-light 1)
  (draw-solid-disk (make-posn X-BULBS Y-GREEN) BULB-RADIUS 'green)))
(define (draw-bulb color)
  (cond
    [(symbol=? 'green  color) (green-on 1)]
    [(symbol=? 'yellow color) (yellow-on 1)]
    [(symbol=? 'red    color) (red-on 1)]
    [else (red-on 1)]
    ))
;; Excercise 6.2.4 
;; clear bulb one and draw bulb 2
;; switch : symbol symbol -> true

(define (switch color0 color1)
  (and  (clear-bulb color0) (draw-bulb color1)))

;; Excercise 6.2.5 
;; next : symbol  ->  symbol
;; to switch a traffic light's current color and to return the next one 
(define (next current-color)
  (cond
    [(and (symbol=? current-color 'red) (switch 'red 'green))
     'green]
    [(and (symbol=? current-color 'yellow) (switch 'yellow 'red))
     'red]
    [(and (symbol=? current-color 'green) (switch 'green 'yellow))
     'yellow]))
(next 'red)
(sleep-for-a-while 1)
(next 'green)
(sleep-for-a-while 1)
(next 'yellow)
(sleep-for-a-while 1)
(next 'red)
(stop)
;; 6.3 Structure Definitions
;; definition constructor selector 
;; defitintion: (define-struct posn(x y))
;; constructor: make-posn
;; selector: posn-x pos-y

(define-struct entry(name zip phone))
(define phonebook (make-entry 'PeterLee 15270 '606-7771))
(entry-name phonebook)
(entry-zip phonebook)
(entry-phone phonebook)

;; Excercise 6.3.2
(define-struct movie (title producer))
(movie-title (make-movie 'ThePhantomMenace 'Lucas))
(movie-producer (make-movie 'TheEmpireStrikesBack 'Lucas))
(define x 3)
(define y 4)
(movie-title (make-movie x y))
(movie-producer (make-movie x y))

;; Excercise 6.3.3
;; structure definition for jet with designation acceleration topspeed and range
(define-struct fighter (designation acc top-speed range))

;; within-range: figheter distance -> whether reachalbe
;; fighter num->boolean
(define (within-range jet distance)
  (>= (fighter-range jet) distance))

;; reduce-range: reduce range field to 80% 
;; fighter -> figher
(define (reduce-range jet)
  (make-fighter (fighter-designation jet)
                (fighter-acc jet)
                (fighter-top-speed jet)
                (* 0.8 (fighter-range jet))))
;; testing
(define test-jet (make-fighter 'f22 4 1000 600))
(check-expect (within-range test-jet 400) #true)
(check-expect (fighter-range (reduce-range test-jet)) (* 0.8 600))

;; 6.4 Data Definition
;; ex: A posn is a structure:
;; (make-posn number number) 

;; Excercise 6.4.2 
;; Data Definition
;; a time is a structure
;; (make-time h m s)
;; where h,m,s are numbers
(define-struct time (h m s))
;; Data Examples
(make-time 8 21 22)

;; Excercis 6.4.3 
;; Data Definition
;; a three-letter-words is a structure
;; (make-three-letter-words a b c)
;; where a b c are smymboles 'a through 'z
(define-struct three-letter-words (a b c))
;; Data Example
(make-three-letter-words 'a 'b 'c)

;; 6.5 Desinging Functions for Compound Data
;; Excercise 6.5.2 Develop the function time->secons, consumes time structure and produces 
;; the number of seconds since midnight

;; time->seconds : time -> num 
;; example (time->seconds(make-time 12 30 2))
;; expected value 45002

;; time is a structure of hours minutes and seconds in number
(define-struct timestruct(h m s))
(define (time->seconds t)
  (+
   (timestruct-s t)
   (* 60  (timestruct-m t) ) 
   (* 3600 (timestruct-h t))))
(check-expect (time->seconds(make-timestruct 12 30 2)) 45002)
(check-expect (time->seconds(make-timestruct 0 0 2)) 2)

;; 6.6 Extended Excercise Moving Circles and Rectangles
(require 2htdp/image)
(require htdp/draw)

(define-struct circle-shape (center radius color))


;; function draws a circle 
(define (draw-a-circle c)
  (draw-circle
      (circle-shape-center c)         
      (circle-shape-radius c)  
      (circle-shape-color c)))

;; (draw-a-circle (make-circle-shape (make-posn 50 50) 50 'red))
;; find out if pos is in circle
;; in-circle? pos, c -> boolean
(define (in-circle? c pos)
  (>= (circle-shape-radius c)
   (sqrt (+ (sqr (- (posn-x (circle-shape-center c)) (posn-x pos))) 
            (sqr (- (posn-y (circle-shape-center c)) (posn-y pos)))))))
(define c1 (make-circle-shape (make-posn 6 2) 1 'red))
(check-expect (in-circle? c1 (make-posn 6 1.5)) #true)
(check-expect (in-circle? c1 (make-posn 9 6)) #false)

;; function that move circle to the right delta
;; circle, delta -> new circle 
(define (translate-circle c delta)
  (make-circle-shape 
                     (make-posn (+ delta (posn-x (circle-shape-center c)))  
                                (posn-y (circle-shape-center c)))              
                     (circle-shape-radius c)
                     (circle-shape-color  c) 
                   )
)
;; function that clears a circle
;; circle-> cleared

(define (clear-a-circle c)
  (clear-circle
   (circle-shape-center c)
   (circle-shape-radius c)))

;; function that draw a cricle, wait for a short time and clears it
(define (draw-and-clear-circle c t)
  (and (draw-a-circle c)
       (sleep-for-a-while t)
       (clear-a-circle c)))
 
;; move-circle: number circle ->circle
;; to draw and clear a circle, translate it by delta pixels
(define (move-circle delta c)
  (cond 
    [(draw-and-clear-circle c 1) (translate-circle c delta)]
    [else c]))

(define a-circle (make-circle-shape (make-posn 50 50) 50 'red))

;; moving a circle 10 pixel to the right four times
(start 300 300)
(draw-a-circle 
   (move-circle 10
                (move-circle 10
                             (move-circle 10
                                          (move-circle 10 a-circle)))))
(stop)

;;rectangles
;; teachpack: draw.ss

;; A rectangle is a structure:
;;   (make-rectangle P W H)
;; where P is a posn, W is a number and H is a number.
(define-struct rectangle (nw-corner width height color))

;; DATA EXAMPLES
(define example-rectangle1 (make-rectangle (make-posn 20 20) 260 260 'red))
(define example-rectangle2 (make-rectangle (make-posn 60 60) 180 180 'blue))

#|
;; Template
(define (fun-for-rectangle a-rectangle)
  ... (rectangle-nw-corner a-rectangle) ...
  ... (rectangle-width a-rectangle) ...
  ... (rectangle-height a-rectangle) ...
  ... (rectangle-color a-rectangle) ...)
|#

; -------------------------------------------------------------------------

;; draw-a-rectangle : rectangle -> true
;; to draw a-rect
(define (draw-a-rectangle a-rectangle)
  (draw-solid-rect
   (rectangle-nw-corner a-rectangle)
   (rectangle-width a-rectangle)
   (rectangle-height a-rectangle)
   (rectangle-color a-rectangle)))

;; EXAMPLES
(start 300 300)
(draw-a-rectangle example-rectangle1)
(draw-a-rectangle example-rectangle2)
