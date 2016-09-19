;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "convert.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
;; lab2
;; 1 Structs
;; Excercise 1
(define-struct file(name extension size))
;; A File is (make-file String Symbol NonNegInteger)
;; Interp: represents a file with the file name, the file extension
;; and the file size

;; 1.1 write down the names of all the functions defined with the creation of structure file
;; constructor,selector, predicate,
;; (make-file name extension size)
;; (file-name a-file)
;; (file-extension a-file)
;; (file-size a-file)
;; (file? )

;; 1.2 write down the signatures of each function
;; 1.3 write down a purpose statements
;; 1.4 write down examples of file using the file structure


;; make-file:  String, NonNegInteger, Symbol -> FILE
;; to make a file type with name size and extention
;; example

(make-file "A" 30 'txt)

;; file-name: FILE -> String
;; findout the name of a file name
;; example
(define F1 (make-file "B"  25 'txt))
(file-name F1)

;; file-extention: File -> Symbol
;; findout a file type
;; example
(file-extension F1)

;; file-extention: File -> Size
;; findout the file size
;; example
(file-size F1)

;; file-extention: File -> Boolean
;; findout whether it is a file type
;; example
(file? F1)

;; 1.5 write a template for File
;; if no more than one class, no cond
#|(define (file-temp afile)
  ...(file-name afile)...
  ...(file-size afile)...
  ...(file-extension afile)...)|#


;; Excercise 2
;; 2.1 Design a structure that captures the programs name, version
;; file extension and size

(define-struct program(name version extension size))
;; A Program is (make-file String NonNegInteger Symbol NonNegInteger)
;; Interp: represents a program with the name, version, the extension
;; and the program size

;; constructor,selector, predicate,
;; (make-program name version extension size)
;; (program-name a-program)
;; (program-extension a-program)
;; (program-version a-program)
;; (program-size a-program)
;; (program?)

;; 2.2-2.4
;; make-program:  String NonNegInteger Symbol NonNegInteger -> Program
;; to make a program type with name verion extension and size 
;; example
(make-program "Program-A" 30 '.txt 20)

;; program-name: Program -> String
;; findout the name of a file name
;; example
(define P1 (make-program "Program-B" 30 '.txt 20))
(program-name P1)

;; program-extention: Program -> Symbol
;; find out a program type
;; example
(program-extension P1)

;; program-extention: Program -> Version
;; find out the program size
;; example
(program-version P1)

;; program-extention: Program -> Size
;; find out the program size
;; example
(program-size P1)

;; program-extention: Program -> Boolean
;; findout whether it is a program type
;; example
(program? P1)

;; 2.5 write a template for Program
#|(define (program-temp aprogram)
  ...(program-name aprogram)...
  ...(program-version aprogram)...
  ...(program-size aprogram)...
  ...(program-extension aprogram)...)|#


;; 3 Pretty Print
;; 3.1 print-file: File->String
;; print file name, extension and size in one pretty string
(define (print-file a-file)
  (string-append
    (file-name a-file)
    "."
    (symbol->string (file-extension a-file))
    "    "
    (number->string(file-size a-file))))

;; test
(define File-Test (make-file "thesis" 'doc 1234))
(check-expect (print-file File-Test) "thesis.doc    1234")

;; 3.2 new-ext: File Symbol -> File
;; function that given a file f and new extention ext
;; return a new file that has the same information
;; with new extention
(define (new-ext f ext)
  (string-append
    (file-name f)
    "."
    (symbol->string ext)
    "    "
    (number->string(file-size f))))
;; test
(define File-Test2 (make-file "thesis" 'doc 1234))
(check-expect (new-ext File-Test2 'pdf) "thesis.pdf    1234")

;; 3.3
;; increase-size : FILE SIZE -> FILE
;; a funtion that given a file f and size s
;; returns a new file that has the same information as f
;; except that its size is now increased by s
(define (increase-size f s)
  (string-append
    (file-name f)
    "."
    (symbol->string (file-extension f))
    "    "
    (number->string (+ s (file-size f)))))
;; test
(define File-Test3 (make-file "thesis" 'doc 1234))
(check-expect (increase-size File-Test3 6) "thesis.doc    1240")

;; 4.1
;; print-program Program->String
;; a function that given a program will return a string
;; with program's information using desired format

(define (print-program p)
  (string-append
    (program-name p)
    "    "
    (number->string (program-version p))
    "    "
    (symbol->string (program-extension p))
    "    "
    (number->string(program-size p))))

;; test
(define ProgramTest (make-program "ProgramTest" 30 'txt 20))
(check-expect (print-program ProgramTest) "ProgramTest    30    txt    20")

