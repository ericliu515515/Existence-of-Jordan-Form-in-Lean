import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.LinearAlgebra.AnnihilatingPolynomial
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.LinearAlgebra.DirectSum.Basis
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.Matrix.Charpoly.Minpoly
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace JF_DEF
/-- The entry `(i, j)` is on the superdiagonal when `j = i + 1`.

This uses the natural-number values of `Fin n`, so the last row has no
superdiagonal entry. -/
def IsSuperdiagonal {n : Nat} (i j : Fin n) : Prop :=
  j.val = i.val + 1

/-- A square matrix is in Jordan form if it has possible nonzero entries only
on the diagonal and superdiagonal, every superdiagonal entry is either `0` or
`1`, and a superdiagonal `1` only connects equal diagonal entries.

This captures the usual block-diagonal Jordan shape without yet proving that a
given linear map is similar to such a matrix. -/
def IsJordanForm {n : Nat} {K : Type _} [Zero K] [One K]
    (A : Matrix (Fin n) (Fin n) K) : Prop :=
  (∀ i j, i ≠ j → ¬ IsSuperdiagonal i j → A i j = 0) ∧
  (∀ i j, IsSuperdiagonal i j → A i j = 0 ∨ A i j = 1) ∧
  (∀ i j, IsSuperdiagonal i j → A i j = 1 → A i i = A j j)

end JF_DEF
