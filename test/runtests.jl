using QuantumInformation
using QuantumInformation.ShortNames
using Base.Test

# write your own tests here
b = SpinBasis(1//2)
up = spinup(b)
down = spindown(b)
id = identityoperator(b)

@test sigmax() ≈ sigmax()
@test sigmax() ≈ full(sigmax())
@test full(sigmax()) ≈ sigmax()
@test full(sigmax()) ≈ full(sigmax())

@test outer(spinup(b), spinup(b)) == spinup(b) ⊗ dagger(spinup(b))
@test inner(spinup(b), spinup(b)) == dagger(spinup(b)) * spinup(b)
n = 5; @test ghz(n) == (basisstate(b^n, 1) + basisstate(b^n, 2^n)) / sqrt(2)

srand(2018)
for i in 1:10
    tmpr = rand(1:5)
    @test sparse_spinallup_dm(tmpr) |> full == dm(basisstate(b^tmpr, 1))
end
for i in 1:10
    tmpr = rand(1:5)
    @test sparse_spinalldown_dm(tmpr) |> full == dm(basisstate(b^tmpr, 2^tmpr))
end

srand(2018)
@test begin
    outcome, state = measure(hadamard() * up, 1)
    outcome == 1 && state ≈ down
end

@test qubit("010") == up ⊗ down ⊗ up
@test qubit("010")' == dagger(qubit("010"))
@test sigmax() == sigmax(SpinBasis(1//2))
@test X() == sigmax()
@test sigmay() == sigmay(SpinBasis(1//2))
@test Y() == sigmay()
@test sigmaz() == sigmaz(SpinBasis(1//2))
@test Z() == sigmaz()
@test sigmam() == sigmam(SpinBasis(1//2))
@test sigmap() == sigmap(SpinBasis(1//2))
@test hadamard() == DenseOperator(b, 1/sqrt(2)*[1 1; 1 -1])
@test H() == hadamard()
@test hadamard(2) == DenseOperator(b, 1/sqrt(2)*[1 1; 1 -1]) ⊗ DenseOperator(b, 1/sqrt(2)*[1 1; 1 -1])
@test sgate() == sparse(DenseOperator(b, [1 0; 0 im]))
@test S() == sgate()
@test sdggate() == sparse(DenseOperator(b, [1 0; 0 -im]))
@test Sdg() == sdggate()
@test tgate() == sparse(DenseOperator(b, [1 0; 0 (1+im)/sqrt(2)]))
@test T() == tgate()
@test tdggate() == sparse(DenseOperator(b, [1 0; 0 (1-im)/sqrt(2)]))
@test Tdg() == tdggate()
@test phaseshift(π/3) == sparse(DenseOperator(b, [1 0; 0 exp(im * π / 3)]))
@test U1(π/3) ≈ phaseshift(π/3)
@test phaseshift(π/3) ≈ singleunitary(0,0,π/3)
@test U2(π/3, π/6) ≈ singleunitary(π/2,π/3, π/6)
@test U3(π/2,π/3, π/6) ≈ singleunitary(π/2,π/3, π/6)
@test controlsgate(2, [1], 2, sigmax()) == cnot()
@test controlsgate(3, [2, 3], 1, sigmax()) ==  identityoperator(b) ⊗ (identityoperator(b^2) - sparse_spinalldown_dm(2)) + sigmax() ⊗ sparse_spinalldown_dm(2)
@test controlsgate(4, [3, 4], 2, sigmax()) == identityoperator(b) ⊗ controlsgate(3, [2, 3], 1, sigmax())
@test cnot() == dm(up) ⊗ id + dm(down) ⊗ sigmax()
@test cnot() == CNOT()
@test cnot(2, 1, 2) == dm(up) ⊗ id + dm(down) ⊗ sigmax()
@test cnot(2, 2, 1) == id ⊗ dm(up) + sigmax() ⊗ dm(down)
@test cnot(3, 1, 2) == dm(up) ⊗ id ⊗ id + dm(down) ⊗ sigmax() ⊗ id
@test cnot(3, 1, 3) == dm(up) ⊗ id ⊗ id + dm(down) ⊗ id ⊗ sigmax()
@test cnot(3, 2, 3) == identityoperator(b) ⊗ (dm(up) ⊗ id + dm(down) ⊗ sigmax())
@test cnot(3, 3, 2) == identityoperator(b) ⊗ (id ⊗ dm(up) + sigmax() ⊗ dm(down))
@test toffoli() == (identityoperator(b^2) - sparse_spinalldown_dm(2)) ⊗ identityoperator(b) + sparse_spinalldown_dm(2) ⊗ sigmax()
@test try
    toffoli(1, [1,2], 3)
catch
    true
end
@test try
    toffoli(3, [1,3], 3)
catch
    true
end
@test CCX() == toffoli()
@test swap() == sparse(dm(qubit("00")) + outer(qubit("01"), qubit("10")) + outer(qubit("10"), qubit("01")) + dm(qubit("11")))
@test SWAP() == swap()

@test try
   tex(up)
   true
catch
   false
end
@test try
   tex(up')
   true
catch
   false
end
@test try
   tex(hadamard() * up)
   true
catch
   false
end
@test try
   tex(sigmay() * up)
   true
catch
   false
end
@test try
   tex(sigmay() * hadamard() * up)
   true
catch
   false
end
