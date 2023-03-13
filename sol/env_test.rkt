#lang racket

(require "./env.rkt")
(require rackunit)

(check-equal?
 (lookup 'pi env)
 3.141592653589793)

(check-equal?
 (lookup 'a
         (extend-env '(a) '(1) env))
 1)
