# ``\LaTeX`` rendering

`SpinBasis` and `NLevelBasis` state can be rendered by MathJax(ASCII art) on IJulia(REPL) as follows.
```julia
cnot() * (H() ⊗ id()) * qubit("00") |> tex
tex(dm(cnot() * (H() ⊗ id()) * qubit("00")), "\\rho") # Second argument is LHS of the equation.
```

**IJulia**

$| \psi \rangle = 0.707 | 00 \rangle+0.707 | 11 \rangle$  
$\rho = 0.5 | 00 \rangle \langle 00 |+0.5 | 00 \rangle \langle 11 |+0.5 | 11 \rangle \langle 00 |+0.5 | 11 \rangle \langle 11 |$

**REPL**
```julia
julia> cnot() * (H() ⊗ id()) * qubit("00") |> tex
|ψ> = 0.707|00> + 0.707|11>

julia> tex(dm(cnot() * (H() ⊗ id()) * qubit("00")), "ρ")
ρ = 0.5 |00⟩⟨00| +0.5 |00⟩⟨11| +0.5 |11⟩⟨00| +0.5 |11⟩⟨11|
```
