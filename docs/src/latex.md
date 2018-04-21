# ``\LaTeX`` rendering

Qubit ( SpinBasis(1//2) ) state can be rendered by MathJax(ASCII art) on IJulia(REPL).
```julia
cnot() * (H() ⊗ id()) * qubit("00") |> tex
```

**IJulia**

$| \psi \rangle = 0.707 | 00 \rangle+0.707 | 11 \rangle$


**REPL**
```julia
julia> cnot() * (H() ⊗ id()) * qubit("00") |> tex
|ψ> = 0.707|00> + 0.707|11>
```
