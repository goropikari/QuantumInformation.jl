id() = identityoperator(SpinBasis(1//2))
const X = sigmax
const Y = sigmay
const Z = sigmaz
const H = hadamard
const S = sgate
const Sdg = sdggate
const T = tgate
const Tdg = tdggate
const U1 = phaseshift
"""
    U2(ϕ::Real, λ::Real)

Equivalent to `sigleunitary(π/2, ϕ, λ)`.
"""
U2(ϕ::Real, λ::Real) = sigleunitary(π/2, ϕ, λ)
const U3 = sigleunitary
const CU = controlsgate
const CNOT = cnot
const CCX = toffoli
const SWAP = swap

export id, X, Y, Z, H, S, Sdg, T, Tdg, U1, U2, U3, CU, CNOT, CCX, SWAP
