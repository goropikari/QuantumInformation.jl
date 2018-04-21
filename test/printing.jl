b = SpinBasis(1//2)
up = spinup(b)

@test try tex(up); true catch false end
@test try tex(up'); true catch false end
@test try tex(im * up); true catch false end
@test try tex((1 + im) * up); true catch false end
@test try tex(-up); true catch false end
@test try tex(im * up); true catch false end
@test try tex(-im * up); true catch false end
@test try tex((-1 - im) * up); true catch false end
@test try tex(qubit("010")); true catch false end
@test try tex(qubit("010"), "ϕ"); true catch false end
@test try tex(hadamard() * up); true catch false end
@test try tex(hadamard() * up, "ρ"); true catch false end
@test try tex(sigmay() * up); true catch false end
@test try tex(sigmay() * hadamard() * up); true catch false end
@test try tex(sigmaz() * hadamard() * up); true catch false end
@test try tex(sigmax()); true catch false end
@test try tex(hadamard(2)); true catch false end
@test try tex((qubit("01") ⊗ basisstate(NLevelBasis(3), 3)) ⊗ qubit("10")'); true catch false end
@test try tex((qubit("01") ⊗ basisstate(NLevelBasis(3), 3)) ⊗ qubit("10")', "ρ"); true catch false end
@test try tex(sparse((qubit("01") ⊗ basisstate(NLevelBasis(3), 3)) ⊗ qubit("10")')); true catch false end
@test try tex(sparse((qubit("01") ⊗ basisstate(NLevelBasis(3), 3)) ⊗ qubit("10")'), "ρ"); true catch false end
