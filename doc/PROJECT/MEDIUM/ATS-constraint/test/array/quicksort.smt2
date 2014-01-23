;; This example demonstrates sorting two arrays and then combining
;; them around a pivot yields a sorted array.

(define-fun partitioned ((a (Array Int Int)) (l Int) (p Int) (u Int)) Bool
    (forall ((i Int) (j Int))
      (=> (<= l i p j u)
          (<= (select a i) (select a p) (select a j)))))

(define-fun sorted ((a (Array Int Int)) (l Int) (u Int)) Bool
  (forall((i Int) (j Int))
         (=> (<= l i j u) (<= (select a i) (select a j)))))

(define-fun merge-left
  ((a (Array Int Int)) (left (Array Int Int))  (pivot Int)) Bool
  (forall ((i Int))
          (=> (<= 0 i pivot) ( = (select a i) (select left i) ))))

(define-fun merge-right
  ((a (Array Int Int)) (right (Array Int Int)) (start Int) (end Int)) Bool
  (forall ((i Int))
          (=> (<= start i end) (= (select a i) (select right (- i start))))))

(define-fun append
  ((a (Array Int Int)) (left (Array Int Int)) (right (Array Int Int))
   (pivot Int) (n Int)) Bool
   (and
    (merge-left a left (- pivot 1)) (merge-right a right  (+ pivot 1) n)))

(declare-fun buffer () (Array Int Int))

(declare-fun left () (Array Int Int))
(declare-fun right () (Array Int Int))

(declare-fun n () Int)
(declare-fun p () Int)

(assert (<= 0 p n))

(assert (sorted left 0 (- p 1)))
(assert (sorted right 0 (- (- n p) 1)))

(assert (append buffer left right p n))

(assert (partitioned buffer 0 p n))

(push 1)
(assert (not (sorted buffer 0 n)))
(check-sat)
(pop 1)