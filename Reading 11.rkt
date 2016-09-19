;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Reading 1|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;; Reading 11 Natural Numbers
;; a natural-number is either 0 or (add1 n) if n is natural 

;; Let us develop the function hellos. It consumes a natural number n and produces a list of n copies of 'hello. 
;; We can write the contract for this function:
;; hellos : N  ->  list-of-symbols
;; to create a list of n copies of 'hello
(define (hellos n)
  (cond 
    [(zero? n) empty]
    [else (cons 'hello (hellos (sub1 n)))]))
(hellos 5)

;; Excercise 11.2.1 
;; repeat: symbol num -> list of symbol
;; output with n occurance of symbol
(define (repeat sym num)
  (cond 
    [(zero? num) empty]
    [else (cons sym (repeat sym (sub1 num)))]))
(repeat 'la 4)

