(declare-const A (Array Int Int))
(declare-const x Int)

(declare-fun acons (Int (Array Int Int)) (Array Int Int))
(declare-fun atail ((Array Int Int)) (Array Int Int))

(assert (forall ((A (Array Int Int))(x Int) (i Int))
  (= (select (acons x A) i) (ite (<= i 0) x (select A (- i 1))))))

(assert (forall ((A (Array Int Int)) (i Int))
  (= (select (atail A) i) (select A (+ i 1)))))

(declare-const i Int)

(assert (>= i 0))

(push)
(assert (not (> i 0)))

(push)
(assert (not (= (select (acons x A) i) x)))
(check-sat)
(pop)
(pop)

(push)
(assert (> i 0))
(assert (not (= (select (acons x A) i) (select A (- i 1)))))
(check-sat)
(pop)