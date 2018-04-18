export hadamard, sgate, sdggate, tgate, tdggate, phaseshift, controlsgate, cnot, toffoli

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
       nc = length(controls) # number of control qubits

       N < nc + 1 && throw("the number of qubits must be larger or equal to $(maximum(vcat(controls, target)))")
       isempty(controls) && error("you don\'t specify control qubits.")
       target ∈ controls && error("target qubit overlaps a control qubit.")
       (target < 1 || target > N) && error("target qubit is out of bound.")

       if !issorted(controls)
              sort!(controls)
       end
       basis = SpinBasis(1//2)
       ctrlstate = sparse_spinalldown_dm(nc) # |11...1><11...1|
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
              error("the number of qubits must be larger or equal to 3.")
       end
       return controlsgate(N, controls, target, sigmax())
end
