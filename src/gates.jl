export hadamard, sgate, sdggate, tgate, tdggate, phaseshift, sigleunitary,
       controlsgate, cnot, toffoli, swap

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
       phaseshift(λ::Real)

phase shift gate
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


function sigleunitary(θ, ϕ, λ)
       x = spzeros(Complex{Float64}, 2, 2)
       x[1,1] = cos(θ/2)
       x[1,2] = - exp(im * λ) * sin(θ/2)
       x[2,1] = exp(im * ϕ) * sin(θ/2)
       x[2,2] = exp(im * (λ+ϕ)) * cos(θ/2)
       return SparseOperator(SpinBasis(1//2), x)
end

"""
       controlsgate(N::Int, controls::Vector{Int}, target::Int, op::Operator)

multi-controlled gate.
# Example
```julia
julia> nqubits, controls, target, op = 3, [1, 2], 3, sigmax();

julia> controlsgate(nqubits, controls, target, op) # equivalent to toffoli gate
SparseOperator(dim=8x8)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
  [1, 1]  =  1.0+0.0im
  [2, 2]  =  1.0+0.0im
  [3, 3]  =  1.0+0.0im
  [4, 4]  =  1.0+0.0im
  [5, 5]  =  1.0+0.0im
  [6, 6]  =  1.0+0.0im
  [8, 7]  =  1.0+0.0im
  [7, 8]  =  1.0+0.0im
```
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
       cnot(N::Int=2, control::Int=1, target::Int=2)

# Example
```julia
julia> cnot()
SparseOperator(dim=4x4)
  basis: [Spin(1/2) ⊗ Spin(1/2)]
  [1, 1]  =  1.0+0.0im
  [2, 2]  =  1.0+0.0im
  [4, 3]  =  1.0+0.0im
  [3, 4]  =  1.0+0.0im

julia> nqubits, control, target = 3, 1, 3;

julia> cnot(nqubits, control, target)
SparseOperator(dim=8x8)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
  [1, 1]  =  1.0+0.0im
  [2, 2]  =  1.0+0.0im
  [3, 3]  =  1.0+0.0im
  [4, 4]  =  1.0+0.0im
  [6, 5]  =  1.0+0.0im
  [5, 6]  =  1.0+0.0im
  [8, 7]  =  1.0+0.0im
  [7, 8]  =  1.0+0.0im
```
"""
cnot(N::Int=2, control::Int=1, target::Int=2) = controlsgate(N, [control], target, sigmax())

"""
       toffoli(N::Int=3, controls::Vector{Int}=[1, 2], target::Int=3)

# Example
```julia
julia> toffoli() # equivalent to  toffoli(3, [1,2], 3)
SparseOperator(dim=8x8)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
  [1, 1]  =  1.0+0.0im
  [2, 2]  =  1.0+0.0im
  [3, 3]  =  1.0+0.0im
  [4, 4]  =  1.0+0.0im
  [5, 5]  =  1.0+0.0im
  [6, 6]  =  1.0+0.0im
  [8, 7]  =  1.0+0.0im
  [7, 8]  =  1.0+0.0im

julia> nqubits, controls, target = 4, [1,2], 3;

julia> toffoli(nqubits, controls, target)
SparseOperator(dim=16x16)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
  [1 ,  1]  =  1.0+0.0im
  [2 ,  2]  =  1.0+0.0im
  [3 ,  3]  =  1.0+0.0im
  [4 ,  4]  =  1.0+0.0im
  [5 ,  5]  =  1.0+0.0im
  [6 ,  6]  =  1.0+0.0im
  [7 ,  7]  =  1.0+0.0im
  [8 ,  8]  =  1.0+0.0im
  [9 ,  9]  =  1.0+0.0im
  [10, 10]  =  1.0+0.0im
  [11, 11]  =  1.0+0.0im
  [12, 12]  =  1.0+0.0im
  [15, 13]  =  1.0+0.0im
  [16, 14]  =  1.0+0.0im
  [13, 15]  =  1.0+0.0im
  [14, 16]  =  1.0+0.0im
```
"""
function toffoli(N::Int=3, controls::Vector{Int}=[1, 2], target::Int=3)
       if N < 3
              error("the number of qubits must be larger or equal to 3.")
       end
       return controlsgate(N, controls, target, sigmax())
end

"""
       swap(N::Int=2, targets::Vector{Int}=[1,2])

# Exapmle
```julia
julia> swap()
SparseOperator(dim=4x4)
  basis: [Spin(1/2) ⊗ Spin(1/2)]
  [1, 1]  =  1.0+0.0im
  [3, 2]  =  1.0+0.0im
  [2, 3]  =  1.0+0.0im
  [4, 4]  =  1.0+0.0im

julia> swap(3, [1,2])
SparseOperator(dim=8x8)
  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]
  [1, 1]  =  1.0+0.0im
  [2, 2]  =  1.0+0.0im
  [5, 3]  =  1.0+0.0im
  [6, 4]  =  1.0+0.0im
  [3, 5]  =  1.0+0.0im
  [4, 6]  =  1.0+0.0im
  [7, 7]  =  1.0+0.0im
  [8, 8]  =  1.0+0.0im
```
"""
function swap(N::Int=2, targets::Vector{Int}=[1,2])
       if N < 2
              error("the number of qubits must be larger or equal to 2.")
       end
       if targets[1] == targets[2]
              error("target qubits mustn't be same.")
       end
       if length(targets) != 2
              error("the number of target qubits must be equal to 2")
       end
       x = spzeros(Complex{Float64}, 4, 4)
       x[1,1] = 1.
       x[3,2] = 1.
       x[2,3] = 1.
       x[4,4] = 1.
       basicswap = SparseOperator(SpinBasis(1//2)^2, x)

       control, target = targets[1], targets[2]
       if N == 2
              return basicswap
       else
              perm = collect(1:N)
              targetpos = N
              state = identityoperator(SpinBasis(1//2)^(N-2)) ⊗ basicswap
              perm[control], perm[end-1] = perm[end-1], perm[control]
              if control == N
                     targetpos = N-1
              end
              perm[target], perm[targetpos] = perm[targetpos], perm[target]

              return permutesystems(state, perm)
       end
end
