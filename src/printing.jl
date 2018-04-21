export tex

"""
    tex(x, statename="ψ") # for Ket and Bra
    tex(x, statename="Operator") # for Operator

LaTeX (ASCII art) rendering for qubits system's Ket, Bra, and Operator in IJulia (REPL).
You can change LHS state name by second argument.

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
function tex(x::Union{Ket,Bra}, statename::String="\\psi")
    try
        str = _md(x, statename)
        display("text/latex", "\$" * str * "\$") # for IJulia
    catch
        str = _aa(x)
        println(str) # for REPL
    end
end
function tex(x::T, statename::String="\\mathrm{Operator}") where T <: Operator
    try
        str = _md(x, statename)
        display("text/latex", "\$" * str * "\$") # for IJulia
    catch
        str = _aa(x)
        println(str) # for REPL
    end
end

"make markdown from Bra and Ket"
function _md(x::Union{Ket,Bra}, statename::String)
    nq = length(x.basis.shape)
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

"make markdown from Operator"
function _md(x::T, statename::String) where T <: Operator
    nq = x.basis_l |> length |> log2 |> Int
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data

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

"make ascii art from Bra and Ket"
function _aa(x::Union{Ket,Bra})
    nq = length(x.basis.shape)
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data
    # braket = Dict(Ket=>["|", ">"], Bra=>["<", "|"])[typeof(x)]
    braket = ifelse(typeof(x) == Ket, ["|", "⟩"], ["⟨", "|"])

    str = "$(braket[1])ψ$(braket[2]) = "
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
"make ascii art from Operator"
function _aa(x::T) where T <: Operator
    nq = x.basis_l |> length |> log2 |> Int
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data

    str = "Operator = "
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
