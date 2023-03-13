#lang eopl

(require "./env.rkt")
(provide (all-defined-out))

(define (list-of pred)
  (lambda (lst)
    (or (null? lst)
        (and (pair? lst)
             (pred (car lst))
             ((list-of pred) (cdr lst))))))

(define (procedure-or-var? exp)
  (cond
    ((not (calc-exp? exp)) #f)
    (else (cases calc-exp exp
            (procedure-exp (arg1 arg2) #t)
            (app-exp (procedure args) #t)
            (var-exp (n) #t)
            (else #f)))))


(define (closure-exp? exp)
  (cond
    ((not (calc-exp? exp)) #f)
    (else (cases calc-exp exp
            (closure-exp (arg1 arg2 arg3) #t)
            (else #f)))))

(define-datatype calc-exp calc-exp?
  (lit-exp
   (value number?))
  (var-exp
   (name symbol?))
  (if-exp
   (test-exp calc-exp?)
   (then-exp calc-exp?)
   (else-exp calc-exp?))
  (procedure-exp
   (parameters (list-of symbol?))
   (body calc-exp?))
  (closure-exp
   (env list?)
   (parameters (list-of symbol?))
   (body calc-exp?))
  (app-exp
   (procedure procedure-or-var?)
   (args (list-of calc-exp?))))

(define (parser exp)
  (cond
    ((symbol? exp) (var-exp exp))
    ((number? exp) (lit-exp exp))
    ((eq? (car exp) 'func) (procedure-exp
                            (cadr exp)
                            (parser (caddr exp))))
    ((eq? (car exp) 'if) (if-exp (parser (cadr exp))
                                 (parser (caddr exp))
                                 (parser (cadddr exp))))
    (else (app-exp (parser (car exp))
                   (map parser (cdr exp))))))