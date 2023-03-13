#lang racket

(require "./parser.rkt")
(require rackunit)

(check-equal?
  (parser '((func (n) n) 42))
  (app-exp (procedure-exp '(n) (var-exp 'n)) (list (lit-exp 42))))
