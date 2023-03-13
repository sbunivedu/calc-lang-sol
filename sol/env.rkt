#lang eopl

(provide extend-env lookup env)

(define (extend-env vars vals env)
  (cond
    ((null? vars) env)
    (else (extend-env (cdr vars) (cdr vals)
                      (cons (list (car vars) (car vals)) env)))))

(define (lookup name env)
  (let ((binding (assq name env)))
    (if binding
        (cadr binding)
        (eopl:error 'lookup "No such varibale: ~a" name))))

(define env (list (list 'pi 3.141592653589793)
                  (list 'e  2.718281828459045)
                  (list '+ +)))