;; interpretation for stampseq_cons
(assert (forall ((A (Array Int Int))(x Int) (i Int))
  (= (select (stampseq_cons x A) i) (ite (<= i 0) x (select A (- i 1))))))

;; interpretation for append

;; base case
(assert (forall ((A (Array Int Int)) (m Int))
  (= (stampseq_append stampseq_nil 0 A m) A)))

;; general case
(assert (forall ((A (Array Int Int)) (B (Array Int Int)) (m Int) (n Int) (i Int))
  (= (select (stampseq_append A m B n) i ) (ite (< i m) (select A i) (select B (- i m))))))


