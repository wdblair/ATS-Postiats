;; An interaction with Z3 that (i think) proves quicksort sorts an array

(define-fun swap ((a (Array Int Int)) (i Int) (j Int)) (Array Int Int)
  (let ((tmp (select a i)))
    (store (store a i (select a j)) j tmp)))

(define-fun partitioned ((a (Array Int Int)) (l Int) (p Int) (u Int)) Bool
    (forall ((i Int) (j Int))
      (=> (and (<= l i p) (<= p j u))
          (<= (select a i) (select a p) (select a j)))))

(define-fun sorted ((a (Array Int Int)) (l Int) (u Int)) Bool
  (forall((i Int) (j Int))
    (=> (<= l i j u) (<= (select a i) (select a j)))))

;; Some array of integers
(declare-fun buffer () (Array Int Int))

(declare-fun n () Int)

(push 1)

(declare-fun p () Int)

;; Suppose we selected some p uniformly at random
(assert (<= 0 p n))

(assert (partitioned buffer 0 p n))

(assert (sorted buffer 0 (- p 1)))
(assert (sorted buffer (+ p 1) n))

(push 1)
(assert (not (sorted buffer 0 n)))
(check-sat)
(pop 2)

;; These constraints will be checked for the loop inside the partition function.

(declare-fun start () Int)
(declare-fun stop  () Int)

(define-fun partitioned-left
    ((a (Array Int Int)) (l Int) (pindex Int) (p Int)) Bool
      (forall ((i Int))
        (=> (and (<= l i ) (< i pindex)) (<= (select a i) (select a p)))))

(define-fun partitioned-right
    ((a (Array Int Int)) (u Int) (pindex Int) (p Int)) Bool
      (forall ((i Int))
        (=> (and (<= pindex i u)) (<= (select a p) (select a i)))))

(declare-fun pindex () Int)

(declare-fun i () Int)

(assert (<= 0 start pindex i))
(assert (<= i stop))

;; This is our base case
;; pindex = start
;; i = start
(push 1)
(assert (not (partitioned-left buffer start start stop)))
(assert (not (partitioned-right buffer start start stop)))
(check-sat)
(pop 1)

(push 1)

;; loop function pre-condition
(assert (partitioned-left buffer start pindex stop))
(assert (partitioned-right buffer i pindex stop))

(push 1)

;; buffer[i] <= buffer[stop]

(assert (<= (select buffer i) (select buffer stop)))

(push 1)
(assert (not (partitioned-left (swap buffer i pindex) start (+ pindex 1) stop)))
(assert (not (partitioned-right (swap buffer i pindex) (+ i 1) (+ pindex 1) stop)))
(check-sat)
(pop 2)

(push 1)

;; buffer[i] > buffer[stop]

(assert (> (select buffer i) (select buffer stop)))

(push 1)
(assert (not (partitioned-left buffer start pindex stop)))
(assert (not (partitioned-right buffer (+ i 1) pindex stop)))
(check-sat)
(pop 2)

;; Final case, when i = stop

(assert (= i stop))

(push 1)

(assert (not (partitioned (swap buffer pindex stop) start pindex stop)))
(check-sat)
(pop 1)