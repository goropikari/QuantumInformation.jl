module QuantumInformation

# package code goes here
import Base: ctranspose
using QuantumOptics
import QuantumOptics: sigmam, sigmap, sigmax, sigmay, sigmaz
export Basis                  , basis                   , logarithmic_negativity  , potentialoperator       , spre,
       Bra                    , basisstate              , manybody                , printing                , states,
       CompositeBasis         , bosonstates             , manybodyoperator        , projector               , steadystate,
       DenseOperator          , coherentstate           , metrics                 , ptrace                  , stochastic,
       DenseSuperOperator     , create                  , momentum                , ptranspose              , subspace,
       FockBasis              , dagger                  , negativity              , qfunc                   , superoperators,
       GenericBasis           , destroy                 , nlevel                  , random                  , tensor,
       Ket                    , diagonaljumps           , nlevelstate             , randoperator            , timecorrelations,
       LazyProduct            , diagonaloperator        , normalize               , randstate               , timeevolution,
       LazySum                , displace                , normalize!              , samplepoints            , tracedistance,
       LazyTensor             , dm                      , number                  , semiclassical           , tracedistance_h,
       ManyBodyBasis          , eigenenergies           , occupation              , sigmam                  , tracedistance_nh,
       MomentumBasis          , eigenstates             , onebodyexpect           , sigmap                  , tracenorm,
       NLevelBasis            , embed                   , operators               , sigmax                  , tracenorm_h,
       Operator               , entropy_vn              , operators_dense         , sigmay                  , tracenorm_nh,
       PPT                    , eval                    , operators_lazyproduct   , sigmaz                  , transform,
       PositionBasis          , expect                  , operators_lazysum       , simdiag                 , transformations,
       SparseOperator         , fermionstates           , operators_lazytensor    , sortedindices           , transition,
       SparseSuperOperator    , fidelity                , operators_sparse        , sparsematrix            , variance,
       SpinBasis              , fock                    , particle                , spectralanalysis        , wigner,
       StateVector            , fockstate               , permutesystems          , spin                    , ⊗,
       SubspaceBasis          , gaussianstate           , phasespace              , spindown,
       SuperOperator          , identityoperator        , polynomials             , spinup,
       bases                  , liouvillian             , position                , spost

# new defined functions
export outer, inner, ghz, sparse_spinallup_dm, sparse_spinalldown_dm, hadamard, sgate, sdggate, tgate, tdggate, phaseshift, controlsgate, cnot, toffoli

QuantumOptics.set_printing(standard_order=true)
# The reasons why the order of tensor product is inverted.
# https://github.com/qojulia/QuantumOptics.jl/blob/395f7077528d36bded0d5ef0652de19b5a9263db/src/printing.jl#L14-L24
# https://qojulia.org/documentation/quantumobjects/operators.html#tensor_order-1

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

# quantum circuit gates
sigmam() = sigmam(SpinBasis(1//2))
sigmap() = sigmap(SpinBasis(1//2))
sigmax() = sigmax(SpinBasis(1//2))
sigmay() = sigmay(SpinBasis(1//2))
sigmaz() = sigmaz(SpinBasis(1//2))
hadamard(n::Int=1) = tensor([DenseOperator(SpinBasis(1//2), 1/sqrt(2)*[1 1; 1 -1]) for i in 1:n]...)
"""
       sgate()

```math
S = \\begin{bmatrix}
       1 & 0 \\\\
       0 & i
\\end{bmatrix}
```
"""
function sgate()
       x = spzeros(Complex{Float64}, 2, 2)
       x[1,1] = 1.
       x[2,2] = im
       return SparseOperator(SpinBasis(1//2), x)
end

"""
       sdggate()

```math
S^\\dagger = \\begin{bmatrix}
       1 & 0 \\\\
       0 & -i
\\end{bmatrix}
```
"""
function sdggate()
       x = spzeros(Complex{Float64}, 2, 2)
       x[1,1] = 1.
       x[2,2] = -im
       return SparseOperator(SpinBasis(1//2), x)
end

"""
       tgate()

```math
T = \\begin{bmatrix}
       1 & 0 \\\\
       0 & \\frac{1 + i}{\\sqrt{2}}
\\end{bmatrix}
```
"""
function tgate()
       x = spzeros(Complex{Float64}, 2, 2)
       x[1,1] = 1.
       x[2,2] = (1 + im) / sqrt(2)
       return SparseOperator(SpinBasis(1//2), x)
end

"""
       tdggate()

```math
T^\\dagger = \\begin{bmatrix}
       1 & 0 \\\\
       0 & \\frac{1 - i}{\\sqrt{2}}
\\end{bmatrix}
```
"""
function tdggate()
       x = spzeros(Complex{Float64}, 2, 2)
       x[1,1] = 1.
       x[2,2] = (1 - im) / sqrt(2)
       return SparseOperator(SpinBasis(1//2), x)
end

"""
       phaseshift(λ)

```math
U(\\lambda) = \\begin{bmatrix}
       1 & 0 \\\\
       0 & e^{i \\lambda}
\\end{bmatrix}
```
"""
function phaseshift(λ::Real)
       x = spzeros(Complex{Float64}, 2, 2)
       x[1,1] = 1.
       x[2,2] = exp(im * λ)
       return SparseOperator(SpinBasis(1//2), x)
end

"""
       controlsgate(N, controls, target, op)
"""
function controlsgate(N::Int, controls::Vector{Int}, target::Int, op::QuantumOptics.operators.Operator)
       nc = length(controls)

       N < nc + 1 && error()
       isempty(controls) && error()
       target ∈ controls && error()

       basis = SpinBasis(1//2)
       ctrlstate = sparse_spinalldown_dm(nc) # |11...1><11...1| controls
       if N == nc + 1
              # (I - |1...1><1...1|) ⊗ I + |1...1><1...1| ⊗ op
              basicstate = (identityoperator(basis^nc) - ctrlstate) ⊗ identityoperator(basis) + ctrlstate ⊗ op
              perm = collect(1:N)
              perm[end], perm[target] = perm[target], perm[end]
       else
              # I ⊗ ⋯ ⊗ I ⊗ ( (I - |1...1><1...1|) ⊗ I + |1...1><1...1| ⊗ op )
              basicstate = tensor([identityoperator(basis) for i in 1:N-(nc+1)]...) ⊗ ( (identityoperator(basis^nc) - ctrlstate) ⊗ identityoperator(basis) + ctrlstate ⊗ op )
              perm = collect(1:N)
              operator_position = N
              for (idx, cidx) in enumerate(controls)
                    perm[cidx], perm[N - nc - 1 + idx] = perm[N - nc - 1 + idx], perm[cidx]
                    if cidx == operator_position
                           operator_position = N - nc - 1 + idx
                    end
              end
              perm[target], perm[operator_position] = perm[operator_position], perm[target]
       end

       return permutesystems(basicstate, perm)
end

"""
       cnot(N, control, target)
"""
cnot(N::Int=2, control=1, target=2) = controlsgate(N, [control], target, sigmax())

"""
       toffoli(N, controls, target)
"""
function toffoli(N::Int=3, controls::Vector{Int}=[1, 2], target::Int=3)
       if N < 3
              error()
       end
       return controlsgate(N, controls, target, sigmax())
end
# function cnot(N::Int=2, control=1, target=2)
#        a = [identityoperator(SpinBasis(1//2)) for i in 1:N]
#        b = copy(a)
#        a[control] = sparsespinup()
#        b[control] = sparsespindown()
#        b[target] = sigmax()
#        return tensor(a...) + tensor(b...)
# end
# function cnot2(N::Int=2, control=1, target=2)
#        basis = SpinBasis(1//2)
#        CNOT = begin
#               x = spzeros(Complex{Float64}, 4, 4)
#               x[1,1] = 1. + 0im
#               x[4,2] = 1. + 0im
#               x[3,3] = 1. + 0im
#               x[2,4] = 1. + 0im
#               SparseOperator(basis^2, x)
#        end
#        if N == 2
#               if control == 1
#                      return CNOT
#               else
#                      return permutesystems(CNOT, [2,1])
#               end
#        end
#        basicstate = tensor( vcat([identityoperator(basis) for i in 1:N-2], CNOT)... )
#        perm = collect(1:N)
#        perm[control], perm[N-1] = perm[N-1], perm[control]
#        perm[target], perm[N] = perm[N], perm[target]
#
#        return permutesystems(basicstate, perm)
# end

end # module
