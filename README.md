# Jordan Form Theorem in Lean

This repository formalizes the existence of Jordan form for finite-dimensional
linear endomorphisms in Lean 4.

The main theorem states that if the minimal polynomial of an endomorphism
splits, then there is a basis in which the matrix of that endomorphism is in
Jordan form.

```lean
theorem exists_basis_matrix_is_jordan_form_of_minpoly_splits
    {K V : Type _} [Field K] [AddCommGroup V] [Module K V]
    [FiniteDimensional K V] (T : V →ₗ[K] V)
    (h_split : (minpoly K T).Splits) :
    ∃ (n : Nat) (b : Basis (Fin n) K V),
      JF_DEF.IsJordanForm (LinearMap.toMatrix b b T)
```

Here `JF_DEF.IsJordanForm` is a matrix-level predicate: all entries off the
diagonal and superdiagonal are zero, every superdiagonal entry is either `0` or
`1`, and a superdiagonal `1` only connects equal diagonal entries.

## Proof Strategy

The formal proof follows the classical module-theoretic route.

1. View the vector space `V` as a `K[X]`-module using the endomorphism `T`, via
   `Module.AEval' T`.
2. Use the structure theorem for finitely generated torsion modules over the PID
   `K[X]` to decompose this module into cyclic quotients.
3. Use the assumption that `minpoly K T` splits to rewrite the irreducible
   cyclic factors as powers of linear factors `(X - C a)`.
4. Construct explicit bases for the quotient modules
   `K[X] ⧸ K[X] ∙ (X - C a) ^ e`.
5. Order the basis vectors so multiplication by `X` has the Jordan-block shape.
6. Transport the direct-sum basis back through the `K[X]`-linear equivalence to
   a basis of `V`.
7. Prove entry-by-entry that the resulting matrix satisfies `IsJordanForm`.

The indexing work is part of the formalization: the proof builds an explicit
equivalence from the sigma-indexed direct-sum basis to `Fin n`, then proves that
predecessor vectors in each cyclic summand land exactly on the superdiagonal.

## Main Files

- `JF/Basic.lean`: definitions of `IsSuperdiagonal` and `IsJordanForm`.
- `JF/ComparatorSolution.lean`: the full formal proof and helper lemmas.
- `JF/ComparatorChallenge.lean`: a compact copy of the theorem statement used
  for independent comparison.
- `blueprint/`: blueprint source and generated documentation for the theorem.

The central declaration is:

```lean
JFComparator.exists_basis_matrix_is_jordan_form_of_minpoly_splits
```

## Building

The project uses Lean:

```text
leanprover/lean4:v4.30.0-rc2
```

Install Lean with `elan`, then run:

```bash
lake update
lake build JF.ComparatorSolution
```

You can also check the solution file directly:

```bash
lake env lean JF/ComparatorSolution.lean
```

## Independent Checking

The repository also includes a
[`leanprover/comparator`](https://github.com/leanprover/comparator) setup. This
is not the mathematical content of the project; it is a way to compare a trusted
statement file with the standalone solution file.

Comparator is configured by `comparator-config.json`. The permitted axioms are:

```json
["propext", "Quot.sound", "Classical.choice"]
```

The challenge file intentionally contains `sorry`; the solution file should not.
The point is that Comparator checks the solution theorem against the trusted
statement and rejects unpermitted axioms such as `sorryAx`.

On macOS, a development check can be run with Comparator's fake sandbox:

```bash
COMPARATOR_LANDRUN="$HOME/Tools/comparator/scripts/fake-landrun.sh" \
COMPARATOR_LEAN4EXPORT="$HOME/Tools/comparator/.lake/packages/lean4export/.lake/build/bin/lean4export" \
PATH="$HOME/.elan/bin:$PATH" \
lake env "$HOME/Tools/comparator/.lake/build/bin/comparator" comparator-config.json
```

For the strongest untrusted-proof check, run Comparator on Linux with real
`landrun`.
