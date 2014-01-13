;; An interaction with Z3 that proves quicksort sorts an array.

(define-fun sorted ((a (Array Int Int)) (l Int) (u Int)) Bool
  (forall((i Int) (j Int))
    (=> (<= l i j u) (<= (select a i) (select a j)))))

(define-fun partitioned ((a (Array Int Int)) (l Int) (p Int) (u Int)) Bool
    (forall ((i Int) (j Int))
      (=> (and (<= l i p) (<= (+ p 1) j u)) (<= (select a i) (select a j)) )))

;; TODO: how could we capture a permutation in Z3?
;; Do we really need to? Could we just use props built
;; using swap operations?

(declare-fun buffer () (Array Int Int))

(declare-fun n () Int)

(declare-fun p () Int)

;; Suppose we select  some p uniformly at random
(assert (<= 0 p n))

(assert (partitioned buffer 0 p n))
(assert (sorted buffer 0 p))
(assert (sorted buffer (+ p 1) n))

(push 1)
(assert (not (sorted buffer 0 n)))
(check-sat)
(pop 1)

