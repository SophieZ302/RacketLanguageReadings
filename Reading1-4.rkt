;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Reading1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp")) #f)))
#|Readings and Excercise of Chapter 1,2 9/10/2016|#
;; 2.1 squaring, sin(angle), max of two number
;; num0, angle, num1, num2 -> sqr(num0), sin(angle),max(num1,num2)
(define  (q_one num0 angle_radi num1 num2)
  (+ (sqr num0) (sin angle_radi) (max num1 num2)
  ))
(check-expect (q_one 1 0 0 1)
             2)

;; 2.2.1 Fahrenheit -> Celsius
;; num -> num
(define (f2c f)
  (/ (* (- f 32) 5) 9))
(check-within (f2c 0) -17.78 0.1)
;(convert-gui f2c)

;; 2.2.2 Dollar -> Euro
;; num -> num
(define (d2u d)
  (* d 0.89))
(check-within (d2u 5) 4.45 0.01)
;(convert-gui d2u)

;; 2.2.3  Area of Triangle
;; num num -> num
(define (tri_area side0 side1)
  (/ (* side0 side1) 2))
(check-within (tri_area 1 2) 1 0.01)


;; 2.2.4  convert three input digits in to a number with the first being the least sig fig
;; num num num -> num
(define (convert3 num0 num1 num2)
  (+ (+ (* num1 10) (* num2  100)) num0))
(check-within (convert3 1 2 3) 321 0.0001)


;; 2.2.5  formulate n/2+2
;; num -> num
(define (f num)
  (+ (/ num 3) 2))
(check-within (f 3) 3 0.0001)

;; 2.3.1  calculate 15%tax and total wage at 12$/hour
;; write a function to calculate tax then calculate total 
;; num -> num
(define (tax grosspay)
  (* grosspay  .15))
(check-within (tax 100) 15 0.0001)

(define (total hour)
  (- (* hour 12) (tax (* hour 12))))
(check-within (total 1) (- 12 (* 12 .15)) 0.01)


;; 2.3.2  find sum of a bag of pennis nickels dimes and quarters
;; num num num num -> num
(define (convert4 num0 num1 num2 num3)
  (/ (+ num0 (* num1 5) (* num2  10) (* num3 25)) 100))
(check-within (convert4 1 1 1 1) 0.41 0.0001)


;; 2.3.3  net profit of movie theater 5 per ticket, cost .5 per ticket and 20 per show
;; num -> num
(define (total_profit num)
  (- (* 5 num) (+ 20 (* .5 num))))
(check-within (total_profit 5) 2.5 0.0001)
;; run time error example
;(define (somef x) (sin x x))


#|Readings and Excercise of Chapter 3,4 9/11/2016|#
;; 3.1 Composing Functions
;; Formulate auxiliary function definitions for every dependency
;; between quantities mentioned in the problem statement or
;; discovered with example calculations.

;; profit: number -> number
;; to compute the profit as the difference between revenue and costs
;; at some given ticket price

(define (profit ticket-price)
  (-  (revenue ticket-price) (cost ticket-price)))
(check-within (profit 5) 415.2 0.001 )

;; revenue: number -> number
;; to compute the revenue, given ticket-price
(define(revenue ticket-price)
   (* ticket-price (attendees ticket-price)))
(check-within (revenue 5) 600 0.001 )

;; cost: number - >number
;; to compute the costs, given ticket-price
(define (cost ticket-price)
  (+ 180 (*  0.04 (attendees ticket-price))))
(check-within (cost 5) (+ 180 (* 120 0.04)) 0.01)
; 3.1.4 modification
;  (*  1.5 (attendees ticket-price)))
;(check-within (cost 5)  (* 1.5 120) 0.001)
  
;; attendees: number -> number
;; to compute the number of attendees, given ticekt-price
(define (attendees ticket-price)
  (+ 120 (* (/ 15 .10) (- 5 ticket-price))))
(check-within (attendees 5) 120 0.001)

;; 3.2 Variable Definitions
;; Give names to frequently used constants
;; and use the names instead of the constants in programs.
(define PI 3.14159)

;; 3.3 Finger Excericse o Composing Functions
;; 3.3.1 English System

(define inch2cm 2.54)
(define foot2in 12)
(define yard2ft 3)
(define rod2yd 5.5)
(define furlong2rd 40)
(define mile2fl 8)

;; length: inches -> cm
(define (i2c inches)
  (* inches inch2cm))
(check-within (i2c 1) 2.54 0.001)
;; length: feet -> inches
(define (f2i feet)
  (* feet foot2in))
(check-within (f2i 1) 12 0.001)
;; lenght: yards -> feet
(define (y2f yard)
  (* yard yard2ft))
(check-within (y2f 1) 3 0.001)
;; length: rods -> yeards
(define (r2y rod)
  (* rod rod2yd))
(check-within (r2y 1) 5.5 0.001)
;; lenght: furlongs->rods
(define (f2r fur)
  (* fur furlong2rd))
(check-within (f2r 1) 40 0.001)
;; length: miles->furlongs
(define (m2f mile)
  (* mile mile2fl))
(check-within (m2f 1) 8 0.001)
;; lenght: feet->cm
(define (f2cm feet)
  (i2c (f2i feet)))
(check-within (f2cm 1) (* 12 2.54) 0.001)
;; length: yards->cm
(define (y2cm yard)
  (i2c (f2i (y2f yard))))
(check-within (y2cm 1) (* 3 12 2.54) 0.001)
;; length: rods->inches
(define (r2in rod)
  (f2i (y2f (r2y rod))))
(check-within (r2in 1) (* 5.5 3 12) 0.001)
;; length: miles->feet
(define (m2ft mile)
  (y2f (r2y (f2r(m2f mile)))))
(check-within (m2ft 1) (* 8 40 5.5 3) 0.001)


;; 3.3.2 Develop the program volume-cylinder.
;; It consumes the radius of a cylinder's base disk and its height;
;; it computes the volume of the cylinder.

(define (volume_cylinder radius height)
  (* height (* PI radius radius)))
(check-within (volume_cylinder 1 1) PI 0.001)


;; 3.3.3. Develop area-cylinder.
;; The program consumes the radius of the cylinder's base disk and its height.
;; Its result is the surface area of the cylinder.

(define (area-cylinder radius height)
  (+ (* PI radius radius) (* PI radius radius) (* 2 PI radius height)))
(check-within (area-cylinder 1 1) 12.57 0.01)


;; 3.3.4. Develop the function area-pipe.
;; It computes the surface area of a pipe, which is an open cylinder.
;; The program consumes three values: the pipe's inner radius, its length,
;; and the thickness of its wall.
(define (area-disk radius)
  (* PI radius radius))

(define (area-loop inner thickness)
  (- (area-disk (+ inner thickness)) (area-disk inner)))

(define (area-lateral radius height)
  (* 2 PI radius height))

(define (area-pipe inner length thickness)
  (+ (area-lateral (+ inner thickness) length) (area-loop inner thickness) (area-loop inner thickness)))

(check-within (area-pipe 1 1 1) (* 10 PI) 0.001)

;; 3.3.5. Develop the program height,
;; which computes the height that a rocket reaches in a given amount of time.
;; If the rocket accelerates at a constant rate g,
;; it reaches a speed of g · t in t time units
;; and a height of 1/2 * v * t where v is the speed at t.
(define g 1)
(define (velocity time)
  (* g time))
(define (height t)
  (* 0.5 (velocity t) t))
(check-within (height 1) 0.5 0.01)

;; 3.3.6 Celcius->Fahrenheit
(define (c2f c)
  (+ 32 (* c 1.8)))
(check-within(c2f 20) 68 0.01)
(check-within (c2f (f2c 80)) 80 0.00001)



#|Readings and Excercise of Chapter 3,4 9/11/2016|#
;; 4.1 Booleans and Realations
;; = < > AND OR NOT
;; 4.2 Functions that test Conditions

;; is-between-5-6? : number -> boolean
;; to determine whether n is between 5 and 6 (exclusive)
(define (is-between-5-6? n)
(and (< 5 n) (< n 6)))
(check-expect (is-between-5-6? 5.5) true)

;; 4.2.1 the interval (3,7]
(define (interval-one num)
  (and (< 3 num) (<= num 7)))
(check-expect (interval-one 7) true)
;; Equations
;; equation1 : number -> boolean
;; to determine whether x is a solution for x2 + 2 · x + 1 = 0
(define (equation1 x)
(= (+ (* x x) (+ (* 2 x) 1)) 0))
(check-expect (equation1 -1) true)

;; 4.3 Conditionals and Conditional Functions
;; Suppose the bank pays 4% for deposits of up to $1,000 (inclusive),
;; 4.5% for deposits of up to $5,000 (inclusive), and
;; 5% for deposits of more than $5,000.
;; Clearly, the function consumes one number and produces one:
;; interest-rate : number -> number
;; to determine the interest rate for the given amount
(define (interest-rate amount)
  (cond
    [(<= amount 1000) 0.040]
    [(<= amount 5000) 0.045]
    [else 0.050]))
(check-expect (interest-rate 4000) 0.045)


;; 4.4 Designing Conditional Functions
;; 4.4.1 Develop the function interest. Like interest-rate,
;; it consumes a deposit amount.
;; Instead of the rate, it produces the actual amount of interest that the money earns in a year.
;; The bank pays a flat 4% for deposits of up to $1,000,
;; a flat 4.5% per year for deposits of up to $5,000, and
;; a flat 5% for deposits of more than $5,000.
(define (interest amount)
  (cond
    [(<= amount 1000) (* amount 0.04)]
    [(<= amount 5000) (* amount 0.045)]
    [else (* amount 0.05)]
    ))
(check-expect (interest 1000) 40)
(check-expect (interest 5000) (* 5000 0.045))
(check-expect (interest 6000) (* 6000 0.05))

;; Exercise 4.4.2. Develop the function tax,
;; which consumes the gross pay and produces the amount of tax owed.
;; For a gross pay of $240 or less, the tax is 0%;
;; for over $240 and $480 or less, the tax rate is 15%;
;; and for any pay over $480, the tax rate is 28%.
;; Also develop netpay.
;; The function determines the net pay of an employee from the number of hours worked.
;; The net pay is the gross pay minus the tax. Assume the hourly pay rate is $12.


(define (tax4 amount)
  (cond
    [(<= amount 240) (* amount 0.0)]
    [(<= amount 480) (* amount 0.15)]
    [else (* amount 0.28)]))
(define (earning hour)
  (* hour 12))
(define (netpay hour)
  (- (earning hour) (tax4 (earning hour))))
(check-within (netpay 10) 120 0.001)
(check-within (netpay 40) (- 480 (* 480 0.15)) 0.001)
(check-within (netpay 50) (- 600 (* 600 0.28)) 0.001)
