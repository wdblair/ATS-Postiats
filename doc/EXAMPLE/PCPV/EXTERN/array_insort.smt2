;; anything left of the zero index is 0

(assert (forall ((A (Array Int Int)) (i Int))
  (=> (< i 0) (= (select A i) 0))))

;; remove

(assert (forall ((A (Array Int Int)) (i Int) (j Int))
  (=> (and (<= 0 j) (<= 0 i))
    (= (select (stampseq_remove A i) j)
      (ite (< j i)
        (select A j)
        (select A (+ j 1)))))))

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
