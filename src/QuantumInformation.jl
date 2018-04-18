module QuantumInformation

# package code goes here
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


QuantumOptics.set_printing(standard_order=true)
# The reasons why the order of tensor product is inverted.
# https://github.com/qojulia/QuantumOptics.jl/blob/395f7077528d36bded0d5ef0652de19b5a9263db/src/printing.jl#L14-L24
# https://qojulia.org/documentation/quantumobjects/operators.html#tensor_order-1

include("basic.jl")
include("gates.jl")
include("printing.jl")


module ShortNames
       using ..QuantumInformation
       include("shortnames.jl")
end # ShortNames
end # module
