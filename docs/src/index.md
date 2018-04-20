# QuantumInformation.jl Documentation

QuantumInformation.jl is a package for learning quantum computation.
I add quantum gates to [QuantumOptics.jl](https://github.com/qojulia/QuantumOptics.jl).

## Installation
```julia
Pkg.clone("https://github.com/goropikari/QuantumInformation.jl")
```

## Basic usage
Make Bell state $| \psi \rangle = \frac{1}{2} (| 00 \rangle + | 11 \rangle)$.
```julia
julia> using QuantumInformation, QuantumInformation.ShortNames

julia> ψ = qubit("00")
Ket(dim=4)
  basis: [Spin(1/2) ⊗ Spin(1/2)]
 1.0+0.0im
 0.0+0.0im
 0.0+0.0im
 0.0+0.0im

julia> ϕ = cnot() * (H() ⊗ id()) * ψ
Ket(dim=4)
  basis: [Spin(1/2) ⊗ Spin(1/2)]
 0.707107+0.0im
      0.0+0.0im
      0.0+0.0im
 0.707107+0.0im

julia> tex(ϕ)
|ψ> = 0.707|00> + 0.707|11>
```
