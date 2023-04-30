#lang racket

(require "./env.rkt")
(require "./parser.rkt")
(require "./evaluator.rkt")

(require rackunit)

(check-equal?
 (closure-exp->parameters
  (closure-exp (empty-env)
               '(a b)
               (var-exp 'a)))
 '(a b))

(check-equal?
 (closure-exp->body
  (closure-exp (empty-env)
               '(a b)
               (var-exp 'a)))
 (var-exp 'a))

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
 (closure-exp->env
  (closure-exp (empty-env)
               '(a b)
               (var-exp 'a)))
 '())

(check-equal?
 (calc
  '(((func (n)
           (func (x)
                 (if pi n x)))
     42)
    e))
 42)

(check-equal?
 (calc '((func (a b) (list a b)) 1 2))
 '(1 2))

(check-equal?
 (calc '((func (n) (max 5 (max 6 (if n 100 4)))) 0))
 6)

(check-equal?
 (calc '((func (n) (max 5 (max 6 (if n 100 4)))) 1))
 100)

(check-equal?
 (calc '((func (n m) (if (< n m) n m)) 6 5))
 5)

(check-equal?
 (calc '(avg 1 2 3 4))
 5/2)

(check-equal?
 (calc '(let ((a 1) (b 2) (c 3)) (+ a b c)))
 6)

(check-equal?
 (calc '(let ((add1 (func (a b) (+ a b)))) (add1 1 2)))
 3)

(check-equal?
 (calc '(let ((f (func (y z) (+ y (- z 5)))))
          (f 2 28)))
 25)
