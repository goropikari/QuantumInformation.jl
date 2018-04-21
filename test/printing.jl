import QuantumInformation: _mdbit, _mdxit
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
@test try tex(qudit("010", 3)); true catch false end
@test try tex(quxit("010", [3,4,3])); true catch false end
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
@test _mdbit(qubit("0"), "psi") == "| psi \\rangle = | 0 \\rangle"
@test _mdbit(qubit("0100"), "psi") == "| psi \\rangle = | 0100 \\rangle"
@test _mdbit(qubit("0100")', "psi") == "\\langle psi | = \\langle 0100 |"
@test _mdbit(dm(qubit("0100")), "psi") == "psi = | 0100 \\rangle \\langle 0100 |"
@test _mdbit(sparse(dm(qubit("0100"))), "psi") == "psi = | 0100 \\rangle \\langle 0100 |"
@test _mdbit(H(4) * qubit("0100"), "psi") == "| psi \\rangle = 0.25 | 0000 \\rangle+0.25 | 0001 \\rangle+0.25 | 0010 \\rangle+0.25 | 0011 \\rangle-0.25 | 0100 \\rangle-0.25 | 0101 \\rangle-0.25 | 0110 \\rangle-0.25 | 0111 \\rangle+0.25 | 1000 \\rangle+0.25 | 1001 \\rangle+0.25 | 1010 \\rangle+0.25 | 1011 \\rangle-0.25 | 1100 \\rangle-0.25 | 1101 \\rangle-0.25 | 1110 \\rangle-0.25 | 1111 \\rangle"
@test _mdxit(quxit("0", [2]), "psi") == "| psi \\rangle = | 0 \\rangle"
@test _mdxit(quxit("02", [2,3]), "psi") == "| psi \\rangle = | 02 \\rangle"
@test _mdxit(quxit("02", [2,3])', "psi") == "\\langle psi | = \\langle 02 |"
@test _mdxit(dm(quxit("02", [2,3])), "psi") == "psi = | 02 \\rangle \\langle 02 |"
@test _mdxit(sparse(dm(quxit("02", [2,3]))), "psi") == "psi = | 02 \\rangle \\langle 02 |"
