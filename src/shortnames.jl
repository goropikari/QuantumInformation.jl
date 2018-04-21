export id, X, Y, Z, H, S, Sdg, T, Tdg, U1, U2, U3, CU, CNOT, CCX, SWAP

"""
    id(n=1)

Identity operator for n qubits system.
"""
function id(n::Int=1)
    return identityoperator(SpinBasis(1//2)^n)
end
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

Equivalent to `singleunitary(π/2, ϕ, λ)`.

```math
U(\\phi, \\lambda) = \\frac{1}{\\sqrt{2}} \\begin{bmatrix}
       1 & -e^{i \\lambda} \\\\
       e^{i \\phi} & e^{i (\\lambda + \\phi)}
\\end{bmatrix}
```
"""
U2(ϕ::Real, λ::Real) = singleunitary(π/2, ϕ, λ)
const U3 = singleunitary
const CU = controlsgate
const CNOT = cnot
const CCX = toffoli
const SWAP = swap
