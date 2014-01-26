;; interpretation for infseq_cons
(assert (forall ((A (Array Int Int)) (x Int) (i Int))
  (= (select (infseq_cons x A) i) (ite (<= i 0) x (select A (- i 1))))))

;; base case for take and drop

(assert (forall ((A (Array Int Int)))
  (= (infseq_take A 0) infseq_nil)))

(assert (forall ((A (Array Int Int)))
  (= (infseq_drop A 0) A)))

;; general case

(declare-const undef Int)

(assert (forall ((A (Array Int Int)) (i Int) (j Int))
  (= (select (infseq_take A i) j) (ite (< j i) (select A j) 0))
))

(assert (forall ((A (Array Int Int)) (i Int) (j Int))
  (= (select (infseq_drop A i) j) (ite (<= 0 j) (select A (+ i j)) undef))
))