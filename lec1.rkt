;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 5001_class1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; include the image library
#|
 block comment
 (circle 100 "solid" "blue")
 (sqrt 256)|#

#|(string-append "hello" " " "world")
(substring "helloworld" 0 5)
(string-length(substring "helloworld" 0 5))|#

#|(overlay
 (square 60 "solid" "yellow")
 (circle 60 "solid" "white")
 (circle 100 "solid" "red")
 )|#

#|(place-image (circle 100 "solid" "red")
             200
             350
             (empty-scene 400 700))|#

;; function definition, signature, purpose statement

;; Number Number -> Image
;; draw two circles overlayed
;;(define (draw-donut inner outer)
;;  (overlay (circle inner "solid" "white")
;;           (circle outer "solid" "red")))
;; function call
;;(draw-donut 30 50)

;; check-expect for tests
#|(check-expect (draw-donut 20 50)
              (overlay (circle 20 "solid" "white")
           (circle 50 "solid" "red")))|#

#|
;; Number -> Number
;; Calculate the area of a circle 
(define (area radius)
   (* pi radius radius))
(check-within (area 1)
              3.14
              0.01)
;(area 2)
|#



;; A Book is a (make-book String String Number)
(define-struct book (author title price))

(define pp (make-book "Jane Austen" "P&P" 5))

;; input types are not defined, interpretive langugae
;; unlinke c 
(define newbook (make-book "new author" true "harry potter"))

;; selectors
(book-author pp)
(book-title pp)
(book-price pp)

;; signature: any->boolean
(book? pp)

(< (book-price pp) 10) ;;book price less than 10

;; signature
;; book-price: Book -> Number
;; book-author: Book -> String




;; Book -> Boolean
;; is the book by jane austen?
(define (by-jane? a-book )
  (string=? (book-author a-book)
                 "Jane Austen"))
(check-expect(by-jane? pp)
             true)
(check-expect(by-jane? newbook)
             false)


;; A Novel is a (make-novel Author String Number)
(define-struct novel (author title price))

;; An Author is a (make-author String String Number)
(define-struct author (first last yob))
(define emma (make-novel (make-author "Jane" "Austin" 1995)
                         "Emma"
                         5))
;; To get author of novel
(author-last (novel-author emma))

;;Uppercase = type  
