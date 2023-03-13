#lang racket

(require "./evaluator.rkt")
(require rackunit)

(check-equal?
 (calc '42)
 42)

(check-equal?
 (calc 'pi)
 3.141592653589793)

(check-equal?
 (calc '(if pi 1 e))
 1)

(check-equal?
 (calc '((func (n) n) 42))
 42)

(check-equal?
 (calc '((func (n) (if n n 2)) 42))
 42)

(check-equal?
 (calc
  '(((func (n)
           (func (x)
                 (if pi n x)))
     42)
    e))
 42)

; if you add ('+ +) to your environment
; the following test cases should pass
(check-equal?
 (calc '(+ 1 2 3))
 6)

(check-equal?
 (calc '(+ 1 2 (+ 3 4 5)))
 15)

