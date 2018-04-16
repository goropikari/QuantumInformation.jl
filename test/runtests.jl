using QuantumInformation
using Base.Test

# write your own tests here
# @test 1 == 2
srand(2018)
b = SpinBasis(1//2)
up = spinup(b)
down = spindown(b)
id = identityoperator(b)

@test outer(spinup(b), spinup(b)) == spinup(b) ⊗ dagger(spinup(b))
@test inner(spinup(b), spinup(b)) == dagger(spinup(b)) * spinup(b)
n = 5; @test ghz(n) == (basisstate(b^n, 1) + basisstate(b^n, 2^n)) / sqrt(2)

for i in 1:10
    tmpr = rand(1:5)
    @test sparse_spinallup_dm(tmpr) |> full == dm(basisstate(b^tmpr, 1))
end
for i in 1:10
    tmpr = rand(1:5)
    @test sparse_spinalldown_dm(tmpr) |> full == dm(basisstate(b^tmpr, 2^tmpr))
end

@test sigmax() == sigmax(SpinBasis(1//2))
@test sigmay() == sigmay(SpinBasis(1//2))
@test sigmaz() == sigmaz(SpinBasis(1//2))
@test sigmam() == sigmam(SpinBasis(1//2))
@test sigmap() == sigmap(SpinBasis(1//2))
@test hadamard() == DenseOperator(b, 1/sqrt(2)*[1 1; 1 -1])
@test hadamard(2) == DenseOperator(b, 1/sqrt(2)*[1 1; 1 -1]) ⊗ DenseOperator(b, 1/sqrt(2)*[1 1; 1 -1])
@test sgate() == sparse(DenseOperator(b, [1 0; 0 im]))
@test sdggate() == sparse(DenseOperator(b, [1 0; 0 -im]))
@test tgate() == sparse(DenseOperator(b, [1 0; 0 (1+im)/sqrt(2)]))
@test tdggate() == sparse(DenseOperator(b, [1 0; 0 (1-im)/sqrt(2)]))
@test phaseshift(π/3) == sparse(DenseOperator(b, [1 0; 0 exp(im * π / 3)]))
@test controlsgate(2, [1], 2, sigmax()) == cnot()
@test controlsgate(3, [2, 3], 1, sigmax()) ==  identityoperator(b) ⊗ (identityoperator(b^2) - sparse_spinalldown_dm(2)) + sigmax() ⊗ sparse_spinalldown_dm(2)
@test controlsgate(4, [3, 4], 2, sigmax()) == identityoperator(b) ⊗ controlsgate(3, [2, 3], 1, sigmax())
@test cnot() == dm(up) ⊗ id + dm(down) ⊗ sigmax()
@test cnot(2, 1, 2) == dm(up) ⊗ id + dm(down) ⊗ sigmax()
@test cnot(2, 2, 1) == id ⊗ dm(up) + sigmax() ⊗ dm(down)
@test cnot(3, 1, 2) == dm(up) ⊗ id ⊗ id + dm(down) ⊗ sigmax() ⊗ id
@test cnot(3, 1, 3) == dm(up) ⊗ id ⊗ id + dm(down) ⊗ id ⊗ sigmax()
@test cnot(3, 2, 3) == identityoperator(b) ⊗ (dm(up) ⊗ id + dm(down) ⊗ sigmax())
@test cnot(3, 3, 2) == identityoperator(b) ⊗ (id ⊗ dm(up) + sigmax() ⊗ dm(down))
@test toffoli() == (identityoperator(b^2) - sparse_spinalldown_dm(2)) ⊗ identityoperator(b) + sparse_spinalldown_dm(2) ⊗ sigmax()
