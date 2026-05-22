import JF.Basic
import Mathlib.LinearAlgebra.AnnihilatingPolynomial
import Mathlib.LinearAlgebra.Basis.Defs
import Mathlib.LinearAlgebra.FiniteDimensional.Basic
import Mathlib.LinearAlgebra.Matrix.Charpoly.Minpoly
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace JFComparator

open Module Polynomial

theorem exists_basis_matrix_is_jordan_form_of_minpoly_splits
    {K V : Type _} [Field K] [AddCommGroup V] [Module K V]
    [FiniteDimensional K V] (T : V →ₗ[K] V)
    (h_split : (minpoly K T).Splits) :
    ∃ (n : Nat) (b : Basis (Fin n) K V),
      JF.IsJordanForm (LinearMap.toMatrix b b T) := by
  sorry

end JFComparator
