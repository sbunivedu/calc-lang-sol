#lang racket

(require "./env.rkt")
(require rackunit)

(define env
  (extend-env (list 'pi 'e)
              (list 3.141592653589793
                    2.718281828459045)
              (empty-env)))

(check-equal?
 (empty-env)
 '())

(check-equal?
 env
 '((e 2.718281828459045) (pi 3.141592653589793)))

(check-equal?
 (lookup 'pi env)
 3.141592653589793)

(check-equal?
 (lookup 'a
         (extend-env '(a b) '(1 2) env))
 1)

(check-equal?
 (lookup 'a
         (extend-env '(a b) '(1 2) env))
 1)

(check-equal?
 (lookup 'a
         (extend-env '(a b a) '(1 2 3) env))
 3)
