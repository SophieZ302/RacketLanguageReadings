;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |Reading 13-15|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; Reading 13-15
;;; Section 13
;; List Abreviations (list a b c)
;;; Section 14
;; 14.1 Structures in Structures

;; 14.2 Binary Search Trees

;; 14.2 Binary Search Trees
;; Excercise 14.2.1 
;; Example

;      11 'Bobby
;         \  
;          \
;         12 'Luke


;      11 'Bobby
;        /  
;       /
;    24 'Luke


;      11 'Bobby
;        /     \
;       /       \
;    24 'Luke    5  'Paul

;; Data Definition 
;; A BT is either
;; - false;
;; - (make-node soc pn lft rgt)
;; Interp: where soc is a number, pn is a symbol, lft,rgt are BT
(define-struct node (ssn name left right))

(define bt1 (make-node 11 'Bobby false (make-node 12 'Luke false false)))
(define bt2 (make-node 11 'Bobby (make-node 24 'Lubke false false) false))
(define bt3 (make-node 11 'Bobby (make-node 24 'Luke false false) (make-node 5'Paul false false)))
  
;; function consumes a number and a BT, determines whether 
;; the number occurs in the tree

;; Signature
;; bt-contains?: Number BT -> Boolean
;; Purpose
;; function checkes whether a number exist in a BT
(define (bt-contains? anum abt)
  (cond
    [(boolean? abt)   #false]
    [else 
     (or
      (= anum (node-ssn abt))
      (bt-contains? anum (node-left abt))
      (bt-contains? anum (node-right abt)))]))
;; Test
(check-expect (bt-contains? 11 bt1) #true)
(check-expect (bt-contains? 5 bt3) #true)
(check-expect (bt-contains? 24 bt2) #true)
(check-expect (bt-contains? 6 bt3) #false)

  
;; 14.2.2 
;; develop search-bt that consumes a number n and a BT
;; if the tree contains a node structure whose soc field is n
;; the function produces the value of the pn field in that node
;; otherwise, function produces false
;; use contains-bt? or use boolean? to find out wether search-bt was successfully
;; used on a sub tree

;;
(define (search-bt n bt)
  )
  
