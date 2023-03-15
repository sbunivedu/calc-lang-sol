#lang eopl

(require "./env.rkt")
(require "./parser.rkt")

(provide (all-defined-out))

(define (evaluator ast env)
  (cases calc-exp ast
    (lit-exp (value) value)
    (var-exp (name) (lookup name env))
    (procedure-exp (parameters body)
                   (closure-exp env parameters body))
    (if-exp (test-exp then-exp else-exp)
            (if (true? (evaluator test-exp env))
                (evaluator then-exp env)
                (evaluator else-exp env)))
    (app-exp (procedure args)
             (applier (evaluator procedure env)
                      (map (lambda (e) (evaluator e env))
                           args)))
    (else #f)))

(define (closure-exp->env closure)
  (cases calc-exp closure
    (closure-exp (env parameters body) env)
    (else #f)))

(define (closure-exp->parameters closure)
  (cases calc-exp closure
    (closure-exp (env parameters body) parameters)
    (else #f)))

(define (closure-exp->body closure)
  (cases calc-exp closure
    (closure-exp (env parameters body) body)
    (else #f)))

(define (applier f values)
  (cond
    ((closure-exp? f)
     (evaluator (closure-exp->body f)
                (extend-env (closure-exp->parameters f)
                            values
                            (closure-exp->env f))))
    (else (apply f values))))

; First, we define those things that can't be defined in terms of others:
(define env (list (list 'pi 3.141592653589793)
                  (list 'e  2.718281828459045)
                  (list '+ +)
                  (list '- -)
                  (list '* *)
                  (list 'list list)
                  (list '= (lambda (a b) (if (= a b) 1 0)))
                  (list '< (lambda (a b) (if (< a b) 1 0)))
                  (list '> (lambda (a b) (if (> a b) 1 0)))
                  (list 'avg (lambda lst (/ (apply + lst) (length lst))))))

; Next, we extend-env with those things that can use the previous things:

(set! env
      (extend-env
       '(min max)
       (list
        (evaluator (parser '(func (a b) (if (< a b) a b))) env)
        (evaluator (parser '(func (a b) (if (> a b) a b))) env))
       env))


(define (calc exp)
  (evaluator (parser exp) env))

(define (true? v)
  (not (= v 0)))
