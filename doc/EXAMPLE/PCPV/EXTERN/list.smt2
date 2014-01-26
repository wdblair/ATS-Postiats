;; interpretation for infseq_cons
(assert (forall ((A (Array Int Int))(x Int) (i Int))
  (= (select (infseq_cons x A) i) (ite (<= i 0) x (select A (- i 1))))))

;; interpretation for append

;; base case
(assert (forall ((A (Array Int Int)) (m Int))
  (= (infseq_append infseq_nil 0 A m) A)))

;; general case
(assert (forall ((A (Array Int Int)) (B (Array Int Int)) (m Int) (n Int) (i Int))
  (= (select (infseq_append A m B n) i ) (ite (< i m) (select A i) (select B (- i m))))))