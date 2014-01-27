(assert (forall ((A (Array Int Int)) (i Int))
  (=> (< i 0) (= (select A i) 0))))

;; cons

(assert (forall ((A (Array Int Int))(x Int))
  (= (select (stampseq_cons x A) 0) x)))

(assert (forall ((A (Array Int Int))(x Int) (i Int))
  (=> (> i 0) (= (select (stampseq_cons x A) i) (select A (- i 1))))))

;; insert

(assert (forall ((A (Array Int Int))(x Int) (i Int) (j Int))
  (=> (and (<= 0 j) (<= 0 i))
    (= (select (stampseq_insert A i x) j) 
      (ite (< j i)
        (select A j)
        (ite (= j i)
          x
          (select A (- j 1)))
         )))))

;; sorted

(assert (forall ((A (Array Int Int)) (n Int))
  (=> (< n 0) (= (stampseq_sorted A n) true))))

(assert (forall ((A (Array Int Int)) (n Int))
  (=> (= n 0) (= (stampseq_sorted A n) true))))

(assert (forall ((A (Array Int Int)) (n Int))
  (=> (= n 1) (= (stampseq_sorted A n) true))))

(assert (forall ((A (Array Int Int)) (i Int) (j Int) (n Int))
  (=> (< 1 n)
    (= (stampseq_sorted A n)
      (=> (<= 0 i j (- n 1)) (<= (select A i) (select A j)))))))
