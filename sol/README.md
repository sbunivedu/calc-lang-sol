# The Calc Language

## Syntax
The concrete syntax for the Calc language is as follows ([] denotes abstract syntax):
```
<expression> ::= <number>
             lit-exp (value)
             ::= <identifier>
             var-exp (name)
             ::= (if <expression> <expression> <expression>)
             if-exp (test-exp then-exp else-exp)
             ::= (func ({<identifier>}*) <expression>)
             procedure-exp (parameters body)
             ::= (<expression> <expression>)
             app-exp (procedure args)
             ::= (let-exp (({<identifier>}*) ({<expression>}*)) <expresion>)
             let-exp (var vals body)
```

Example programs:
```
42

pi

(if pi 1 e)

((func (n) n) 42)

((func (n) (if n n 2)) 42)

(let ((a 1) (b 2) (c 3)) (+ a b c))

(let ((add1 (func (a b) (+ a b)))) (add1 1 2))

```

## Syntax datatype
```
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
```
