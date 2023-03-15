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
 (calc
  '(((func (n)
           (func (x)
                 (if pi n x)))
     42)
    e))
 42)