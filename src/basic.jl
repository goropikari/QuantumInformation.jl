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
