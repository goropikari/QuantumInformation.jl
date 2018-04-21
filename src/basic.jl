import Base: isapprox, ctranspose
import StatsBase: sample, pweights

isapprox(x::Ket, y::Ket) = (x.basis == y.basis) && x.data ≈ y.data
isapprox(x::Bra, y::Bra) = (x.basis == y.basis) && x.data ≈ y.data
isapprox(x::SparseOperator, y::SparseOperator) = (x.basis_l == y.basis_l) && (x.basis_r == y.basis_r) && x.data ≈ y.data
isapprox(x::DenseOperator, y::DenseOperator) = (x.basis_l == y.basis_l) && (x.basis_r == y.basis_r) && x.data ≈ y.data
isapprox(x::SparseOperator, y::DenseOperator) = (x.basis_l == y.basis_l) && (x.basis_r == y.basis_r) && x.data ≈ y.data
isapprox(x::DenseOperator, y::SparseOperator) = (x.basis_l == y.basis_l) && (x.basis_r == y.basis_r) && x.data ≈ y.data

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

"""
    outer(x::Ket, y::Ket)

Construct outer product from two kets, ``|x⟩⟨y|``.
"""
outer(x::QuantumOptics.states.Ket, y::QuantumOptics.states.Ket) = x ⊗ y'

"""
    inner(x::Ket, y::Ket)

Calculate inner product from two kets, ``⟨x|y⟩``.
"""
inner(x::QuantumOptics.states.Ket, y::QuantumOptics.states.Ket) = x' * y


"""
    qubit(x)

Prepare n-qubit state from binary.

# Example
```julia
julia> qubit("010")
Ket(dim=8)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
 0.0+0.0im
 0.0+0.0im
 1.0+0.0im
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im
```
"""
function qubit(x::String)
    nq = length(x)
    ar = parse.(Int, split(x, "")) + 1
    basis = SpinBasis(1//2)
    return tensor( basisstate.(basis, ar)... )
end

"""
    qudit(x, dim)

Prepare n-qudit state

# Example
```
julia> qudit("010", 3)
Ket(dim=27)
  basis: [NLevel(N=3) ⊗ NLevel(N=3) ⊗ NLevel(N=3)]
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im
 1.0+0.0im
    ⋮
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im

 julia> qudit("010", 3) |> tex
|ψ⟩ = |010⟩
```
"""
function qudit(x::String, dim::Int)
    nq = length(x)
    ar = parse.(Int, split(x, "")) + 1
    basis = NLevelBasis(dim)
    return tensor( nlevelstate.(basis, ar)... )
end

"""
    quxit(x::String, dims::Vector{Int})

Prepare a composite state which the dimension of i th system is `dims[i]`.

# Example
```
julia> quxit("021", [2,3,2])
Ket(dim=12)
  basis: [NLevel(N=2) ⊗ NLevel(N=3) ⊗ NLevel(N=2)]
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im
    ⋮
 0.0+0.0im
 1.0+0.0im
 0.0+0.0im
```
"""
function quxit(x::String, dims::Vector{Int})
    @assert length(x) == length(dims)
    nq = length(x)
    ar = parse.(Int, split(x, "")) + 1
    return tensor(basisstate.(NLevelBasis.(dims), ar)...)
end

"""
    sparse_spinallup_dm(n)

n qubits all up state density matrix
```math
| 0 \\rangle \\langle 0 |^{\\otimes n}
```
"""
function sparse_spinallup_dm(n::Int)
       x = spzeros(Complex{Float64}, 2^n, 2^n)
       x[1,1] = 1. + 0im
       return SparseOperator(SpinBasis(1//2)^n, x)
end

"""
    sparse_spinalldown_dm(n)

n qubits all down state density matrix
```math
| 1 \\rangle \\langle 1 |^{\\otimes n}
```
"""
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
Measure n th qubit w.r.t standard basis.

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
