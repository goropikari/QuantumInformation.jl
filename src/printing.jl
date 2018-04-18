export tex

function tex(x::Union{Ket,Bra})
    nq = length(x.basis.shape)
    isfirstterm = true
    perm = collect(reverse(1:nq))
    if nq != 1
        x = permutesystems(x, perm)
    end
    data = x.data
    braket = Dict(Ket=>["|", "\\rangle"], Bra=>["\\langle", "|"])[typeof(x)]

    str = "$(braket[1]) \\psi $(braket[2]) = "
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
                    str *= " $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                else
                    str *= "$(n2s(ent)) $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                end
            else
                if value == 1.0
                    str *= "+ $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                elseif n2s(ent)[1] == '-'
                    str *= "$(n2s(ent)) $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                else
                    str *= "+$(n2s(ent)) $(braket[1]) $(bin(idx-1, nq)) $(braket[2])"
                end
            end
        end
    end
    try
        display("text/latex", "\$\$" * str * "\$\$") # for IJulia
    catch
        println("\$\$" * str * "\$\$") # for REPL
    end
end

function n2s(x)
    str = ""
    if typeof(x) <: Real
        if x > zero(x)
            str *= "$(x)"
        else
            str *= "$(x)"
        end
    elseif typeof(x) <: Complex
        str1, str2 = "", ""
        if !(x.re ≈ 0)
            str1 *= "$(round(x.re, 3))"
        end
        if !(x.im ≈ 0)
            if x.im ≈ one(x.im)
                str2 *= "i"
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
    end
    return str
end
