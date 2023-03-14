#lang eopl

(provide empty-env extend-env lookup)

(define (empty-env)
  '())

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
