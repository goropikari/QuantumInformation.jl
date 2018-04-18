import Base: isapprox, ctranspose
import StatsBase: sample, pweights
export outer, inner, sparse_spinallup_dm, sparse_spinalldown_dm, ghz, measure

isapprox(x::Ket, y::Ket) = (x.basis == y.basis) && x.data ≈ y.data
isapprox(x::Bra, y::Bra) = (x.basis == y.basis) && x.data ≈ y.data

ctranspose(op::QuantumOptics.particle.FFTKets) = dagger(op::QuantumOptics.particle.FFTKets)
ctranspose(op::QuantumOptics.particle.FFTOperators) = dagger(op::QuantumOptics.particle.FFTOperators)
ctranspose(op::QuantumOptics.operators_lazytensor.LazyTensor) = dagger(op::QuantumOptics.operators_lazytensor.LazyTensor)
ctranspose(op::QuantumOptics.operators_lazyproduct.LazyProduct) = dagger(op::QuantumOptics.operators_lazyproduct.LazyProduct)
ctranspose(op::QuantumOptics.operators_lazysum.LazySum) = dagger(op::QuantumOptics.operators_lazysum.LazySum)
ctranspose(x::QuantumOptics.operators_sparse.SparseOperator) = dagger(x::QuantumOptics.operators_sparse.SparseOperator)
ctranspose(x::QuantumOptics.operators_dense.DenseOperator) = dagger(x::QuantumOptics.operators_dense.DenseOperator)
ctranspose(x::QuantumOptics.states.Ket) = dagger(x::QuantumOptics.states.Ket)
ctranspose(x::QuantumOptics.states.Bra) = dagger(x::QuantumOptics.states.Bra)
ctranspose(a::QuantumOptics.operators.Operator) = dagger(a::QuantumOptics.operators.Operator)

outer(x::QuantumOptics.states.Ket, y::QuantumOptics.states.Ket) = x ⊗ y'
inner(x::QuantumOptics.states.Ket, y::QuantumOptics.states.Ket) = x' * y
function sparse_spinallup_dm(n::Int)
       x = spzeros(Complex{Float64}, 2^n, 2^n)
       x[1,1] = 1. + 0im
       return SparseOperator(SpinBasis(1//2)^n, x)
end
function sparse_spinalldown_dm(n::Int)
       x = spzeros(Complex{Float64}, 2^n, 2^n)
       x[2^n,2^n] = 1. + 0im
       return SparseOperator(SpinBasis(1//2)^n, x)
end

"""
       ghz(n)

n qubits GHZ(Greenberger–Horne–Zeilinger) state
```math
| \\mathrm{GHZ} \\rangle = \\frac{| 0 \\rangle^{\\otimes n} + | 1 \\rangle^{\\otimes n}}{\\sqrt{2}}
```

# Example
```julia
julia> n = 3;

julia> ghz(n)
Ket(dim=8)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
 0.707107+0.0im
      0.0+0.0im
      0.0+0.0im
      0.0+0.0im
      0.0+0.0im
      0.0+0.0im
      0.0+0.0im
 0.707107+0.0im
```
"""
function ghz(n::Int=3)
       b = SpinBasis(1//2)^n
       state = basisstate(b, 1) + basisstate(b, 2^n)
       normalize!(state)
       return state
end


"""
    measure(state, n)

Projective measurement with standard basis.
Measure nth qubit w.r.t standard basis.

Return outcome (0 or 1) and post-meamurement state
"""
function measure(state::Ket, n::Int=1)
    nqubit = state.basis.shape |> length
    mops = [identityoperator(SpinBasis(1//2)) for i in 1:nqubit]
    mops[n] = spinup(SpinBasis(1//2)) |> dm |> sparse
    mop = tensor(mops...)
    p = real( trace( mop * dm(state) ) )

    outcome = sample(0:1, pweights([p, 1-p]))
    if outcome == 0
        state = mop * state / sqrt(p)
    else
        mops[n] = spindown(SpinBasis(1//2)) |> dm |> sparse
        mop = tensor(mops...)
        state = mop * state / sqrt(1-p)
    end
    return outcome, state
end
