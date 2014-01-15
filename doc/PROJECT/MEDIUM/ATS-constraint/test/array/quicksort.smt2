;; An interaction with Z3 that proves quicksort sorts an array

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

;; TODO: how could  we capture a permutation in Z3?  Do we really need
;; to? Could we just use props  that contain static arrays built using
;; just swap operations?

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

(declare-fun start () Int)
(declare-fun stop  () Int)


(define-fun partitioned-part 
  ((a (Array Int Int)) (l Int) (pindex Int) (p Int) (u Int)) Bool
    (forall ((i Int) (j Int))
      (=> (and (< l i pindex) (<= pindex j) (< j u))
          (<= (select a i) (select a p) (select a j)))))

(declare-fun pindex () Int)

(push 1)
(assert (not (partitioned-part buffer start start  n start)))
(check-sat)
(pop 1)

;; Try to go from partitioned-part to partitioned

(assert (partitioned-part buffer start pindex n n))

(push 1)
(assert (not (partitioned (swap buffer pindex n) start pindex n)))
(check-sat)
(get-model)
(pop 1)
