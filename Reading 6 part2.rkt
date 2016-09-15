;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Reading 6 part2|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; Excercise 6.6.7
;; data definition, structure definition for rectangle
;; template for fun-for-rect that consumes rectangles

;; teachpack:draw.ss

;; Data Definition:
;; a rect is a structure:
;; (make-rect posn(x,y), num, num, symbol) 
;; a rectangle characterized by its upper left corner,
;; width, height and color

;; Stucture Definition:
(define-struct rect(pos width height color))


;; Template
;; fun-for-rect: rect -> ???
#|(define (fun-for-rect a-rect)
    ...(rect-pos a-rect)...
    ...(rect-width a-rect)...
    ...(rect-height a-rect)...
    ...(rect-color a-rect)...
|#


;; Exercise 6.6.8.
;; Use the template fun-for-rect to develop draw-a-rectangle.
;; The function consumes a rectangle structure and
;; draws the corresponding rectangle on the screen.
;; In contrast to circles, the entire rectangle is painted in the matching color.
;; Remember to use (start 300 300) to create the canvas before testing the function.



;; draw-a-rectangle: rect-> true
;; program consume a rectangle structure and outputs on screen filled with color
(define (draw-a-rectangle a-rect)
  (draw-solid-rect
   (rect-pos a-rect)
   (rect-width a-rect)
   (rect-height a-rect)
   (rect-color a-rect)))

;; test
(start 300 300)
(define rect0 (make-rect (make-posn 20 20) 260 260 'red))
(define rect1 (make-rect (make-posn 60 60) 180 180 'blue))
(draw-a-rectangle rect0)
(draw-a-rectangle rect1)

;; Exercise 6.6.9.
;; Use the template fun-for-rect to develop in-rectangle?.
;; The function consumes a rectangle structure and a posn
;; and determines whether or not the pixel is inside the rectangle.
;; A pixel is within a rectangle if its horizontal and vertical distances
;; to the upper-left corner are positive and
;; smaller than the width and height of the rectangle, respectively.


;; in-rectangle?: rect posn -> boolean
;; determines wheter or not the pixel is inside the rec
(define (in-rectangle? a-rect point)
 (and (> (posn-x point) (posn-x (rect-pos a-rect)))
       (> (posn-y point) (posn-y (rect-pos a-rect)))
       (< (- (posn-x point) (posn-x (rect-pos a-rect))) (rect-width a-rect))
       (< (- (posn-y point) (posn-y (rect-pos a-rect))) (rect-height a-rect))) 
  )
;; test
(define pt0 (make-posn 30 30))
(define pt1 (make-posn 0 0))

(check-expect (in-rectangle? rect0 pt0) #true)
(check-expect (in-rectangle? rect0 pt1) #false)


;; Exercise 6.6.10.
;; Use the template fun-for-rect to develop translate-rectangle.
;; The function consumes a rectangle structure and a number delta.
;; The result is a rectangle whose
;; upper-left corner is delta pixels to the right of the input.

;; translate-rectangle: rect num -> rect
;; move to right by delta

(define (translate-rectangle a-rect delta)
  (make-rect
    (make-posn (+ delta (posn-x (rect-pos a-rect))) (posn-y (rect-pos a-rect)))
    (rect-width a-rect)
    (rect-height a-rect)
    (rect-color a-rect)))
;; test
(check-expect (translate-rectangle rect0 10) (make-rect (make-posn 30 20) 260 260 'red))

;; Exercise 6.6.11.
;; Use the template fun-for-rect to develop clear-a-rectangle.
;; It consumes a rectangle structure and clears the corresponding rectangle on the canvas.

;; clear-a-rectangle: rect -> true
;; clears the rectangle
(define (clear-a-rectangle a-rect)
  (clear-solid-rect
   (rect-pos a-rect)
   (rect-width a-rect)
   (rect-height a-rect)
   (rect-color a-rect)))

;; test
(clear-a-rectangle rect0)
(clear-a-rectangle rect1)
;; Exercise 6.6.12.1
;; Develop draw-and-clear-rectangle,
;; which draws a rectangle, sleeps for a while, and then clears the rectangle.

;; draw-and-clear-rectangle: rect -> true
(define (draw-and-clear-rectangle rect)
  (and (draw-a-rectangle rect)
       (sleep-for-a-while 1)
       (clear-a-rectangle rect))
  )
;; test
(draw-and-clear-rectangle rect0)

;; Exercise 6.6.12.2
;; Finally, create a rectangle
;; and use the functions of this exercise set to move it four times.  ;; move-rectangle : number rectangle  ->  rectangle
;; to draw and clear a rectangle, translate it by delta pixels

(define (move-rectangle delta a-rectangle)
  (cond
    [(draw-and-clear-rectangle a-rectangle) 
     (translate-rectangle a-rectangle delta)]
    [else a-rectangle]))

;; test
(draw-a-rectangle
 (move-rectangle 30
                 (move-rectangle 30
                                 (move-rectangle 30
                                                 (move-rectangle 30 rect1)))))


