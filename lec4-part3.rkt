;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lec4-part3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; A List-of-number is one of:
;; -'()
;; - (cons Number List-of-number)

;; (deinfe (lop-temp alop)
;;  ... (cond [(empty? alop)...]
;;            [else...
;;               ...lop-temp(rest alop)... ]))

;; Design a function that sums the numbers in a List-of-number
(define l1 (cons 1 (cons 2 (cons 3 '()))))

;; test
(check-expect (sum l1) 6)
(check-expect (sum '()) 0)
;; sum : List-of-numbers -> number
;; calculate the sum list of numbers
(define (sum alist)
  (cond
    [(empty? alist) 0]
    [else
     (+ (first alist) (sum (rest alist)))]))