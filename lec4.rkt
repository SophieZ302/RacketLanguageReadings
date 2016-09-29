;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lec4) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; an employee is a (make-employee Personal String Number Number SSN)
(define-struct emp  (personal position id salary ssn))

;; A Personal is a (make-personal String String Address)
(define-struct personal (First Last addr))

;; An address is a (make-addr String String String Number)
(define-struct addr (street city state zip))

;; A SSN is a (make-ssn 3-digit-num 2-digit-num 4-digit-num)
(define-struct ssn (pre mid post))

;; A 3-digit-num
;; A 2-digit-num
;; A 1-digit-num

;; employ template
;(define (emp-temp e)
;  ... (presonal-temp (emp-personal e))...
;  ... (emp-position e)...
;  ... (emp-id e)...
;  ... (emp-salary e)...
;  ... (ssn-temp(emp-ssn e))...)

;; personal temp
;(define (personal-temp p)
;  ...(personal-first)...
;  ...(personal-last)...
;  ...(addr-temp (personal-addr))...)

;; address temp
;(define (addr-temp a)
;  ...(addr-street a)...
;  ...(addr-city a)...
;  ...(addr-state a)...
;  ...(addr-zip a)...)

;; example
(define e1 (make-emp (make-personal "Jane" "Smith" (make-addr "elliot" "boston" "MA" 02464)) "boss" 123 200000 (make-ssn 012 012 0012)))

;; Employee Number -> Employee
;; produces employee with new zip code
;; todo (define (new-zip e num) )