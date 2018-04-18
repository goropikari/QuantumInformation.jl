b = SpinBasis(1//2)
up = spinup(b)
down = spindown(b)
# id = identityoperator(b)

@test qubit("010") ≈ qubit("010")
@test qubit("010")' ≈ qubit("010")'
@test (qubit("010")')' ≈ qubit("010")
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
