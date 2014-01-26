;; interpret infseq_cons

;; base case 
(assert (forall ((A (Array Int Int)) (x Int))
  (= (select (infseq_cons x A) 0) x)))

;; general case
(assert (forall ((A (Array Int Int)) (x Int) (i Int))
  (= (select (infseq_cons x A) i) (ite (<= i 0) x (select A (- i 1))))))

;; interpret take & drop

;; base case

(assert (forall ((A (Array Int Int)))
  (= (infseq_take A 0) infseq_nil)))

(assert (forall ((A (Array Int Int)))
  (= (infseq_drop A 0) A)))

;; general case

(declare-const undef Int)

(assert (forall ((A (Array Int Int)) (i Int) (j Int))
  (= (select (infseq_take A i) j) (ite (< j i) (select A j) undef))
))

(assert (forall ((A (Array Int Int)) (i Int) (j Int))
  (= (select (infseq_drop A i) j) (ite (and (<= 0 i) (<= 0 j)) (select A (+ i j)) undef))
))

;; interpret append

;; base case
(assert (forall ((A (Array Int Int)) (m Int))
  (= (infseq_append infseq_nil 0 A m) A)))

;; general case
(assert (forall ((A (Array Int Int)) (B (Array Int Int)) (m Int) (n Int) (i Int))
  (= (select (infseq_append A m B n) i ) (ite (< i m) (select A i) (select B (- i m))))))