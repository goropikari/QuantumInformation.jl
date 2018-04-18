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

include("gates.jl")

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



end # module
