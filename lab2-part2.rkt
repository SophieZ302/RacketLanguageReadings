;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab2-part2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; lab2
;; 2 Itemization
;; Excercise 1

;; A Media is one of
;; - 'dvd
;; - 'cd
;; - 'blueray
;; - 'floppy
;; INTERP: represents each kind of media kept at the store

;; A Peripheral is one of
;; - "keyboard"
;; - "mouse"
;; - "driving wheel"
;; - "headset"
;; - "controller"
;; INTERP: represents each kind of peripheral kept at the store

;; 1.1 write template for Media and Peripheral
#|(define (media-temp amedia)
  (cond 
    [(symbol=? 'dvd amedia)   ...]
    [(symbol=? 'cd amedia)    ...]
    [(symbol=? 'blueray amedia) ...]
    [(symbol=? 'floppy amedia) ...]
    ))|#

#|(define (peripheral-temp peripheral)
  (cond 
    [(string=? "keyboard" peripheral)   ...]
    [(string=? "mouse" peripheral)    ...]
    [(string=? "driving wheel" peripheral) ...]
    [(string=? "headset" peripheral) ...]
    [(string=? "controller" peripheral) ...]
    ))|#
;;
;; 1.2
;; media?  Symbol->Boolean
;; given any value to check if it is a type of media
(define (media? amedia)
  (cond
    [(not (symbol? amedia))  #false ]
    [(symbol=? 'dvd amedia)   #true]
    [(symbol=? 'cd amedia)    #true]
    [(symbol=? 'blueray amedia)#true]
    [(symbol=? 'floppy amedia)#true]
    [else #false]
    ))
;; test
(check-expect (media? "hh") #false)
(check-expect (media? 'dvd) #true)
(check-expect (media? 'cd) #true)
(check-expect (media? 'blueray) #true)
(check-expect (media? 'floppy) #true)
(check-expect (media? 'love) #false)

;; 1.3
;; peripheral?  String->Boolean
;; given any value to check if it is a type of media
(define (peripheral? ap)
  (cond
    [(not (string? ap))          #false]
    [(string=? "keyboard" ap)     #true]
    [(string=? "mouse" ap)        #true]
    [(string=? "driving wheel" ap)#true]
    [(string=? "headset" ap)      #true]
    [(string=? "controller" ap)   #true]
    [else #false]
    ))
;; test
(check-expect (peripheral? "hh") #false)
(check-expect (peripheral? "keyboard") #true)
(check-expect (peripheral? "mouse") #true)
(check-expect (peripheral? "driving wheel") #true)
(check-expect (peripheral? "headset") #true)
(check-expect (peripheral? "controller") #true)
(check-expect (peripheral? 'love) #false)

;; 1.4
;; tax-media Symbol Number -> Number
;; Design a function that given a Media item and its price
;; returns the amount of sales tax
(define (tax-media amedia price)
  (cond 
  [(symbol? amedia)(cond 
    [(symbol=? 'dvd amedia)     (* price 0.05)]
    [(symbol=? 'cd amedia)      (* price 0.03)]
    [(symbol=? 'blueray amedia) (* price 0.07)]
    [(symbol=? 'floppy amedia)  (* price 0.02)]
    )]
  [else #false]))
;; test
(check-expect (tax-media 'dvd 100) 5)
(check-expect (tax-media 'cd 100) 3)
(check-expect (tax-media 'blueray 100) 7)
(check-expect (tax-media 'floppy 100) 2)
(check-expect (tax-media 23 100) #false)


;; 1.5
;; tax-peripheral: String Number -> Number
;; a function that given a Peripheral item and tis price returns the amount of tax
(define (tax-p ap price)
  (cond 
  [(string? ap)(cond
                 [(string=? "keyboard" ap)    (* price 0.025)]
                 [(string=? "mouse" ap)       (* price 0.015)]
                 [(string=? "driving wheel" ap)(* price 0.035)]
                 [(string=? "headset" ap)     (* price 0.052)]
                 [(string=? "controller" ap)   (* price 0.06)]
    )]
   [else #false]
  ))
;; test
(check-expect (tax-p "keyboard" 100) 2.5)
(check-expect (tax-p "mouse" 100) 1.5)
(check-expect (tax-p "driving wheel" 100) 3.5)
(check-expect (tax-p "headset" 100) 5.2)
(check-expect (tax-p "controller" 100) 6)
(check-expect (tax-p 'la 100) #false)

;; 1.6 Design a new data defintion MediaOrPeripheral that can be one of Media or Periperal
;; provide template

#|(define (MediaOrPeripheral amp)
  (cond
    [(string=? "keyboard" peripheral)   ...]
    [(string=? "mouse" peripheral)    ...]
    [(string=? "driving wheel" peripheral) ...]
    [(string=? "headset" peripheral) ...]
    [(string=? "controller" peripheral) ...]
    [(symbol=? 'dvd amedia)   ...]
    [(symbol=? 'cd amedia)    ...]
    [(symbol=? 'blueray amedia) ...]
    [(symbol=? 'floppy amedia) ...]
    ))|#

;; 1.7
;; MediaorPeripheral: String or Symbol -> Number
(define (MediaOrPeripheral amp price)
  (cond
    [(symbol? amp) (cond
                     [(symbol=? 'dvd amp)     (* price 0.05)]
                     [(symbol=? 'cd amp)      (* price 0.03)]
                     [(symbol=? 'blueray amp) (* price 0.07)]
                     [(symbol=? 'floppy amp)  (* price 0.02)])]
    [(string? amp) (cond
                     [(string=? "keyboard" amp)    (* price 0.025)]
                     [(string=? "mouse" amp)       (* price 0.015)]
                     [(string=? "driving wheel" amp)(* price 0.035)]
                     [(string=? "headset" amp)     (* price 0.052)]
                     [(string=? "controller" amp)   (* price 0.06)])]
    [else #false]
    ))
;; test
(check-expect (MediaOrPeripheral 'dvd 100) 5)
(check-expect (MediaOrPeripheral 'cd 100) 3)
(check-expect (MediaOrPeripheral 'blueray 100) 7)
(check-expect (MediaOrPeripheral 'floppy 100) 2)
(check-expect (MediaOrPeripheral "keyboard" 100) 2.5)
(check-expect (MediaOrPeripheral "mouse" 100) 1.5)
(check-expect (MediaOrPeripheral "driving wheel" 100) 3.5)
(check-expect (MediaOrPeripheral "headset" 100) 5.2)
(check-expect (MediaOrPeripheral "controller" 100) 6)
(check-expect (MediaOrPeripheral 199 100) #false)
