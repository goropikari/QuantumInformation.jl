import QuantumOptics.printing: permuted_sparsedata, permuted_densedata
export tex

"""
    tex(x, statename="ψ") # for Ket and Bra
    tex(x, statename="Operator") # for Operator

LaTeX (ASCII art) rendering for composite (SpinBasis and NLevelBasis) system's Ket, Bra, and Operator on IJulia (REPL).
If you use this on IJulia, you can change LHS state name by second argument.

# Example (REPL)
```julia
ulia> using QuantumInformation.ShortNames

julia> ψ = cnot() * (H() ⊗ id()) * qubit("00")
Ket(dim=4)
  basis: [Spin(1/2) ⊗ Spin(1/2)]
 0.707107+0.0im
      0.0+0.0im
      0.0+0.0im
 0.707107+0.0im

julia> tex(ψ)
|ψ⟩ = 0.707|00⟩ + 0.707|11⟩

julia> dm(ψ)
DenseOperator(dim=4x4)
  basis: [Spin(1/2) ⊗ Spin(1/2)]
 0.5+0.0im  0.0+0.0im  0.0+0.0im  0.5+0.0im
 0.0+0.0im  0.0+0.0im  0.0+0.0im  0.0+0.0im
 0.0+0.0im  0.0+0.0im  0.0+0.0im  0.0+0.0im
 0.5+0.0im  0.0+0.0im  0.0+0.0im  0.5+0.0im

julia> dm(ψ) |> tex
Operator = 0.5 |00⟩⟨00| +0.5 |00⟩⟨11| +0.5 |11⟩⟨00| +0.5 |11⟩⟨11|
```
"""
function tex(x::Union{Ket,Bra}, statename::String="")
    if isempty(statename) && isdefined(Main, :IJulia) && Main.IJulia.inited
        statename = "\\psi"
    elseif isempty(statename)
        statename = "ψ"
    end

    if all(x.basis.shape .== 2)
        if isdefined(Main, :IJulia) && Main.IJulia.inited
            str = _mdbit(x, statename)
            display("text/latex", "\$" * str * "\$") # for IJulia
        else
            str = _aabit(x, statename)
            println(str) # for REPL
        end
    else
        if isdefined(Main, :IJulia) && Main.IJulia.inited
            str = _mdxit(x, statename)
            display("text/latex", "\$" * str * "\$") # for IJulia
        else
            str = _aaxit(x, statename)
            println(str) # for REPL
        end
    end
end
function tex(x::Union{DenseOperator,SparseOperator}, statename::String="")
    if isempty(statename) && isdefined(Main, :IJulia) && Main.IJulia.inited
        statename = "\\mathrm{Operator}"
    elseif isempty(statename)
        statename = "Operator"
    end
    if all(x.basis_l.shape .== 2) && all(x.basis_r.shape .== 2)
        if isdefined(Main, :IJulia) && Main.IJulia.inited
            str = _mdbit(x, statename)
            display("text/latex", "\$" * str * "\$") # for IJulia
        else
            str = _aabit(x, statename)
            println(str) # for REPL
        end
    else
        if isdefined(Main, :IJulia) && Main.IJulia.inited
            str = _mdxit(x, statename)
            display("text/latex", "\$" * str * "\$") # for IJulia
        else
            str = _aaxit(x, statename)
            println(str) # for REPL
        end
    end
end

"make markdown for Bra and Ket (qubit system)"
function _mdbit(x::Union{Ket,Bra}, statename::String)
    nq = length(x.basis.shape)
    isfirstterm = true
    if nq != 1
        perm = collect(reverse(1:nq))
        x = permutesystems(x, perm)
    end
    data = x.data
    braket = ifelse(typeof(x) == Ket, ["|", "\\rangle"], ["\\langle", "|"])

    str = "$(braket[1]) $(statename) $(braket[2]) = "
    for (idx, ent) in enumerate(data)
        if ent ≈ 1
            value = 1.0
        else
            value = ent
        end
        if !(ent ≈ 0)
            if isfirstterm
                isfirstterm = false
                if value == 1.
                    str *= "$(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                else
                    str *= "$(n2s(ent)) $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                end
            else
                if n2s(ent)[1] == '-'
                    str *= "$(n2s(ent)) $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                else
                    str *= "+$(n2s(ent)) $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                end
            end
        end
    end

    return str
end
function _mdxit(x::Union{Ket,Bra}, statename::String) # quxit system
    shape = x.basis.shape
    nq = length(shape)
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data
    braket = ifelse(typeof(x) == Ket, ["|", "\\rangle"], ["\\langle", "|"])

    str = "$(braket[1]) $(statename) $(braket[2]) = "
    for (idx, ent) in enumerate(data)
        if ent ≈ 1
            value = 1.0
        else
            value = ent
        end
        if !(ent ≈ 0)
            if isfirstterm
                isfirstterm = false
                if value == 1.
                    str *= "$(braket[1]) $(xit(idx, shape)) $(braket[2])"
                else
                    str *= "$(n2s(ent)) $(braket[1]) $(xit(idx, shape)) $(braket[2])"
                end
            else
                if n2s(ent)[1] == '-'
                    str *= "$(n2s(ent)) $(braket[1]) $(xit(idx, shape)) $(braket[2])"
                else
                    str *= "+$(n2s(ent)) $(braket[1]) $(xit(idx, shape)) $(braket[2])"
                end
            end
        end
    end

    return str
end

"make markdown for Operator (qubits system)"
function _mdbit(x::Union{DenseOperator,SparseOperator}, statename::String)
    nq = x.basis_l.shape |> length
    isfirstterm = true
    if typeof(x) == DenseOperator
        data = permuted_densedata(x)
    elseif typeof(x) == SparseOperator
        data = permuted_sparsedata(x)
    end

    str = "$(statename) = "
    for i in 1:2^nq
        for j in 1:2^nq
            ent = data[i,j]
            if ent ≈ 1
                value = 1.0
            else
                value = ent
            end
            if !(ent ≈ 0)
                if isfirstterm
                    isfirstterm = false
                    if value == 1.
                        str *= "| $(bin(i-1, nq)) \\rangle \\langle $(bin(j-1, nq)) |"
                    else
                        str *= "$(n2s(ent)) | $(bin(i-1, nq)) \\rangle \\langle $(bin(j-1, nq)) |"
                    end
                else
                    if value == 1.0
                        str *= "+ | $(bin(i-1, nq)) \\rangle \\langle $(bin(j-1, nq)) |"
                    elseif n2s(ent)[1] == '-'
                        str *= "$(n2s(ent)) | $(bin(i-1, nq)) \\rangle \\langle $(bin(j-1, nq)) |"
                    else
                        str *= "+$(n2s(ent)) | $(bin(i-1, nq)) \\rangle \\langle $(bin(j-1, nq)) |"
                    end
                end
            end

        end
    end

    return str
end
function _mdxit(x::Union{DenseOperator,SparseOperator}, statename::String)
    rshape = x.basis_r.shape
    lshape = x.basis_l.shape
    ncol = prod(rshape)
    nrow = prod(lshape)

    isfirstterm = true
    if typeof(x) == DenseOperator
        data = permuted_densedata(x)
    elseif typeof(x) == SparseOperator
        data = permuted_sparsedata(x)
    end

    str = "$(statename) = "
    for i in 1:nrow
        for j in 1:ncol
            ent = data[i,j]
            if ent ≈ 1
                value = 1.0
            else
                value = ent
            end
            if !(ent ≈ 0)
                if isfirstterm
                    isfirstterm = false
                    if value == 1.
                        str *= "| $(xit(i, lshape)) \\rangle \\langle $(xit(j, rshape)) |"
                    else
                        str *= "$(n2s(ent)) | $(xit(i, lshape)) \\rangle \\langle $(xit(j, rshape)) |"
                    end
                else
                    if value == 1.0
                        str *= "+ | $(xit(i, lshape)) \\rangle \\langle $(xit(j, rshape)) |"
                    elseif n2s(ent)[1] == '-'
                        str *= "$(n2s(ent)) | $(xit(i, lshape)) \\rangle \\langle $(xit(j, rshape)) |"
                    else
                        str *= "+$(n2s(ent)) | $(xit(i, lshape)) \\rangle \\langle $(xit(j, rshape)) |"
                    end
                end
            end

        end
    end

    return str
end

"make ASCIIart for Bra and Ket (qubits system)"
function _aabit(x::Union{Ket,Bra}, statename::String="")
    nq = length(x.basis.shape)
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data
    # braket = Dict(Ket=>["|", ">"], Bra=>["<", "|"])[typeof(x)]
    braket = ifelse(typeof(x) == Ket, ["|", "⟩"], ["⟨", "|"])

    str = "$(braket[1])$(statename)$(braket[2]) = "
    for (idx, ent) in enumerate(data)
        if ent ≈ 1
            value = 1.0
        else
            value = ent
        end
        if !(ent ≈ 0)
            if isfirstterm
                isfirstterm = false
                if value == 1.
                    str *= "$(braket[1])$(bin(idx-1, nq))$(braket[2])"
                else
                    str *= "$(n2s(ent))$(braket[1])$(bin(idx-1, nq))$(braket[2])"
                end
            else
                if n2s(ent)[1] == '-'
                    str *= " $(n2s(ent))$(braket[1])$(bin(idx-1, nq))$(braket[2])"
                else
                    str *= " + $(n2s(ent))$(braket[1])$(bin(idx-1, nq))$(braket[2])"
                end
            end
        end
    end

    return str
end
function _aaxit(x::Union{Ket,Bra}, statename::String="")
    shape = x.basis.shape
    nq = length(shape)
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data
    braket = ifelse(typeof(x) == Ket, ["|", "⟩"], ["⟨", "|"])

    str = "$(braket[1])$(statename)$(braket[2]) = "
    for (idx, ent) in enumerate(data)
        if ent ≈ 1
            value = 1.0
        else
            value = ent
        end
        if !(ent ≈ 0)
            if isfirstterm
                isfirstterm = false
                if value == 1.
                    str *= "$(braket[1])$(xit(idx, shape))$(braket[2])"
                else
                    str *= "$(n2s(ent))$(braket[1])$(xit(idx, shape))$(braket[2])"
                end
            else
                if n2s(ent)[1] == '-'
                    str *= " $(n2s(ent))$(braket[1])$(xit(idx, shape))$(braket[2])"
                else
                    str *= " + $(n2s(ent))$(braket[1])$(xit(idx, shape))$(braket[2])"
                end
            end
        end
    end

    return str
end
"make ASCIIart for Operator"
function _aabit(x::Union{DenseOperator,SparseOperator}, statename::String="")
    nq = x.basis_l |> length |> log2 |> Int
    isfirstterm = true
    if typeof(x) == DenseOperator
        data = permuted_densedata(x)
    elseif typeof(x) == SparseOperator
        data = permuted_sparsedata(x)
    end

    str = "$(statename) = "
    for i in 1:2^nq
        for j in 1:2^nq
            ent = data[i,j]
            if ent ≈ 1
                value = 1.0
            else
                value = ent
            end
            if !(ent ≈ 0)
                if isfirstterm
                    isfirstterm = false
                    if value == 1.
                        str *= "|$(bin(i-1, nq))⟩⟨$(bin(j-1, nq))|"
                    else
                        str *= "$(n2s(ent)) |$(bin(i-1, nq))⟩⟨$(bin(j-1, nq))|"
                    end
                else
                    if value == 1.0
                        str *= " + |$(bin(i-1, nq))⟩⟨$(bin(j-1, nq))|"
                    elseif n2s(ent)[1] == '-'
                        str *= " $(n2s(ent)) |$(bin(i-1, nq))⟩⟨$(bin(j-1, nq))|"
                    else
                        str *= " +$(n2s(ent)) |$(bin(i-1, nq))⟩⟨$(bin(j-1, nq))|"
                    end
                end
            end

        end
    end

    return str
end
function _aaxit(x::Union{DenseOperator,SparseOperator}, statename::String="")
    isfirstterm = true
    rshape = x.basis_r.shape
    lshape = x.basis_l.shape
    ncol = prod(rshape)
    nrow = prod(lshape)

    isfirstterm = true
    if typeof(x) == DenseOperator
        data = permuted_densedata(x)
    elseif typeof(x) == SparseOperator
        data = permuted_sparsedata(x)
    end

    str = "$(statename) = "
    for i in 1:nrow
        for j in 1:ncol
            ent = data[i,j]
            if ent ≈ 1
                value = 1.0
            else
                value = ent
            end
            if !(ent ≈ 0)
                if isfirstterm
                    isfirstterm = false
                    if value == 1.
                        str *= "|$(xit(i, lshape))⟩⟨$(xit(j, rshape))|"
                    else
                        str *= "$(n2s(ent)) |$(xit(i, lshape))⟩⟨$(xit(j, rshape))|"
                    end
                else
                    if value == 1.0
                        str *= "+ |$(xit(i, lshape))⟩⟨$(xit(j, rshape))|"
                    elseif n2s(ent)[1] == '-'
                        str *= "$(n2s(ent)) |$(xit(i, lshape))⟩⟨$(xit(j, rshape))|"
                    else
                        str *= "+$(n2s(ent)) |$(xit(i, lshape))⟩⟨$(xit(j, rshape))|"
                    end
                end
            end

        end
    end
    return str
end

"""
    n2s(x)

number to string for tex function.
"""
function n2s(x::T) where T <: Complex
    str = ""
    str1, str2 = "", ""
    if !(x.re ≈ 0)
        str1 *= "$(round(x.re, 3))"
    end
    if !(x.im ≈ 0)
        if x.im ≈ one(x.im)
            str2 *= "i"
        elseif -x.im ≈ one(x.im)
            str2 *= "-i"
        else
            str2 *= "$(round(x.im, 3))i"
        end
    end
    if !isempty(str1) && x.im > zero(x.im)
        str2 = "+" * str2
    end
    str = str1 * str2
    if !isempty(str1) && !isempty(str2)
        str = "(" * str * ")"
    end
    return str
end


"""
    xit(n::Int, dims::Vector{Int})

# Arguments
- `n::Int`: n th row(column) of qubit/operator array.
- `dims::Vector{Int}`: N-ary array
"""
function xit(m::Int, dims::Vector{Int})
    m = m - 1
    str = ""
    nquxit = length(dims)
    product = prod(dims[2:end])
    for ith in 1:nquxit-1
        d = div(m, product)
        m = m - d * product
        product = div(product, dims[ith+1])
        str *= string(d)
    end
    str *= string(m)
    return str
end
