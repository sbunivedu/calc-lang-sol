#lang racket

(require "./parser.rkt")
(require rackunit)

(check-equal?
 (procedure-or-var? 'a)
 #f)

(check-equal?
 (procedure-or-var? (var-exp 'a))
 #t)

(check-equal?
 (procedure-or-var? (procedure-exp '(a b)
                                   (lit-exp 42)))
 #t)

(check-equal?
 (closure-exp? (lit-exp 42))
 #f)

(check-equal?
 (closure-exp? (closure-exp '()
                            '(a b)
                            (lit-exp 42)))
 #t)

(check-equal?
  (parser 42)
  (lit-exp 42))

(check-equal?
  (parser 'a)
  (var-exp 'a))

(check-equal?
  (parser '(if pi 1 e))
  (if-exp (var-exp 'pi)
          (lit-exp 1)
          (var-exp 'e)))

(check-equal?
  (parser '(func (a b) a))
  (procedure-exp '(a b)
                 (var-exp 'a)))

(check-equal?
  (parser '((func (a b) a) 1 2))
  (app-exp (procedure-exp '(a b)
                          (var-exp 'a))
           (list (lit-exp 1)
                 (lit-exp 2))))
