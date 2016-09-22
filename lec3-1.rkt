;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lec3-1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; lec3
;; enumeration - traffic light red/yellow/green, tax bracket
;; itemization

(define RADIUS 150)
(define SPEED (quotient RADIUS 5))
(define BALL (circle RADIUS "solid" "red"))
(define WIDTH (* 8 RADIUS))
(define MID RADIUS)
(define BACKGROUND (empty-scene WIDTH (* 2 RADIUS)))
(define TXT (text "press any key" 33 "black"))

;; A SG is one of:
;; - String - "Press any key"
;; - Running
;; - Resting

(define-struct running (x dir))
;; A Running is a (make-running  Number Direction)

(define-struct resting (x dir))
;; A Resting is a (make-resting Number Direction)

;; A Direction is one of:
;; -1
;; 1
;; interpretation: -1 means right to left, 1 is left to right


(define sg0 "press any key")
(define sg1 (make-running 200 1))
(define sg2 (make-resting 200 -1))

;; Design Recepe for World Programs
;; 1. define constants - non-changing
;; 2. define world - what is changing
;;    give data definition and examples
;; 3. wishlist- worlds to responds to

;; SG -> SG
;; launch the stop and go program
(define (main str)
  (big-bang str
            (to-draw render-sg)
            (on-tick next-ball)
            (on-key start-pause)))
;; withlist render-sg
;; design recepe: signature, purpose, test, template 
;; render-sg: SG -> Image
;; draw the current world onto the background
;; 3 test for string/running/resting

#| template of sg
(define (sg-temp asg)
  (cond
    [(string? asg) ...] ;; safe from seg fault produced by (string=?)
    [(running? asg)
     ...(running-x asg)...
     ...(running-dir asg)...]
    [(resting? asg)
     ...(resting-x asg)...
     ...(resting-dir asg)...]))|#

(check-expect (render-sg sg0) (place-image TXT (/ WIDTH 2) MID BACKGROUND));
(check-expect (render-sg sg1) (place-image BALL 200 MID BACKGROUND))
(check-expect (render-sg sg2) (place-image BALL 200 MID BACKGROUND))

(define (render-sg asg)
  (cond
    [(string? asg) (place-image TXT (/ WIDTH 2) MID BACKGROUND)] 
    [(running? asg)
     (place-image BALL (running-x asg) MID BACKGROUND)]
    [(resting? asg)
     (place-image BALL (resting-x asg) MID BACKGROUND)]))

;; start-pause: SG keyEvent -> SG
;; start the ball rolling or pause the ball
 (check-expect (start-pause sg0 " ") (make-running 0 1))
 (check-expect (start-pause sg1 "k") (make-resting 200 1))
 (check-expect (start-pause sg2 "g") (make-running 200 -1))

(define (start-pause asg akey)
  (cond
    [(string? asg) (make-running 0 1)] 
    [(running? asg) (make-resting (running-x asg) (running-dir asg))]
    [(resting? asg) (make-running (resting-x asg) (resting-dir asg))]))

;; designning next tick function
;; next-ball: SG -> SG
;; move/flip direction of ball if running,
;; nothing happens if string, stop
;; examples
(check-expect (next-ball sg0) sg0)
(check-expect (next-ball sg1) (make-running (+ 200 SPEED) 1))
(check-expect (next-ball (make-running 200 -1)) (make-running (- 200 SPEED) -1))
(check-expect (next-ball sg2) sg2)
(check-expect (next-ball (make-running WIDTH 1))(make-running (- WIDTH 1) -1))
(check-expect (next-ball (make-running 0 -1)) (make-running 1 1))

(define (next-ball asg)
  (cond
    [(string? asg) asg] 
    [(running? asg) (if(< 0 (running-x asg) WIDTH) ;;use if when there are only two option
                       (move-ball asg)
                       (flip asg))]
    [(resting? asg) asg]))

;; move-ball: Runing -> Runing
;; move ball right or left depending on direction
;; testing
(check-expect (move-ball sg1)(make-running (+ 200 SPEED) 1))
(check-expect (move-ball (make-running 200 -1)) (make-running (- 200 SPEED) -1))
;; template
;; struct with parts
#|(define (move-ball asg)
  (make-running 
  ...(running-x asg)...
  ...(running-dir asg)...
  )))|#

(define (move-ball asg)
  (make-running (+ (running-x asg) (* SPEED (running-dir asg))) 
                (running-dir asg)))


;; flip: Running->Running
;; flip direction of the ball  depending on direction
;; testing
(check-expect (flip (make-running WIDTH 1)) (make-running (- WIDTH 1) -1))
(check-expect (flip (make-running 0 -1)) (make-running 1 1))

;; template
;; struct with parts
#|(define (flip asg)
  (make-running 
  ...(running-x asg)...
  ...(running-dir asg)...
  )))|#

(define (flip asg)
  (cond
    [(<= (running-x asg) 0)
      (make-running (+ (running-x asg) 1)
                    1)]
    [(>= (running-x asg)  WIDTH)
      (make-running (- (running-x asg) 1)
                    -1)]))

(main "string")