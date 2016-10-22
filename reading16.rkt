;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname reading) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
;;Reading
;;16-19
;;31-32
;;20-22

;; 16.1 Data Analysis 
;; 16.2 Defining Data classes and Refining Them
;; A File is a symbol

;; A Directory is either
;; - '()
;; - (cons f d) where f is a file and d is a dir; or
;; - (cons d1 d2) where d1 and d2 are dirs
;; INTERP: the first data definition says that files are represented by their names
;;         the second one caputres how a directory is constructed by adding files
;;         and directories

;; Data Example
(define D0 '())
(define D1 (cons 'file '()))
(define D2 (cons (cons 'file '()) (cons 'file '())))


;; 16.2.2 Develop the function how-many, which consumes a dir and
;; produces the number of files in the dir tree

;; how-many: Directory -> NonNegNum
;; count the number of files in a dir tree
(define (how-many d)
  (cond
    [(empty? d) 0]
    [(symbol? (first d)) (+ 1 (how-many (rest d)))]
    [ else (+ (how-many (first d))
              (how-many (rest d)))]))
;; Tests
(check-expect (how-many D0) 0)
(check-expect (how-many D1) 1)
(check-expect (how-many D2) 2)
(check-expect (how-many (list 'part1 'part2 'part3)) 3)
(check-expect (how-many (list (list 'part1 'part2 'part3) 
                              (list (list 'hang 'draw) 
                                    (list 'read!))
                              'read!))
              7)

;; 16.2.5
(define-struct dir(name content))
;; dir is a (make-dir Symbol List-of-Files-and-Directories)
;; represents a diretory with name and contents
;; Template
#; (define (dir-fn adir)
     (... (dir-name adir)...
          (lofd-fn (dir-content adir))...))


;; A List-of-Files-and-Directories is either
;; - '()
;; - (cons f d) where f is a file and d is a LOFD; or
;; - (cons d1 d2) where d1 is a dir and d2 is a LOFD
;; Template
#; (define (lofd-fn al)
     (cond
       [(empty? al)...]
       [(symbol? (first al) ) 
        (lofd-fn (rest al))]
       [else 
        (dir-fn (fist al))
        (lofd-fn (rest al))]))
;; Data Examples
(define L0 '())
(define L1 (cons 'file L0))

;; Data Examples
(define DD0 (make-dir 'd0 L0))
(define DD1 (make-dir 'd1 L1))

(define L2 (cons DD1 L1))
(define DD2 (make-dir 'd2 L2))
;; how-many2: Directory -> NonNegNum
;; takes a directory and calculates the number of files in the dir tree
(define (how-many2 adir)
      (count-lofd (dir-content adir)))
;; Test
(check-expect (how-many2 DD0) 0)
(check-expect (how-many2 DD1) 1)
(check-expect (how-many2 DD2) 2)

;; count-lofd: LOFD -> NonNegNum
;; counts the number of files in a LOFD
(define (count-lofd al)
     (cond
       [(empty? al) 0]
       [(symbol? (first al))  
        (+ 1 (count-lofd (rest al)))]
       [else 
        (+ (how-many2 (first al))
           (count-lofd (rest al)))]))
;; Test 
(check-expect (count-lofd L0) 0)
(check-expect (count-lofd L1) 1)
(check-expect (count-lofd L2) 2)

;; 16.3 Refining Functions and Programs