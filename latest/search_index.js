var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "QuantumInformation.jl",
    "title": "QuantumInformation.jl",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#QuantumInformation.jl-1",
    "page": "QuantumInformation.jl",
    "title": "QuantumInformation.jl",
    "category": "section",
    "text": "QuantumInformation.jl is a package for learning quantum computation."
},

{
    "location": "api.html#",
    "page": "Basic functions",
    "title": "Basic functions",
    "category": "page",
    "text": ""
},

{
    "location": "api.html#Basic-functions-1",
    "page": "Basic functions",
    "title": "Basic functions",
    "category": "section",
    "text": "QuantumInformation.qubit\nQuantumInformation.ghz\nQuantumInformation.outer\nQuantumInformation.inner\nQuantumInformation.measure\nQuantumInformation.parse_spinallup_dm\nQuantumInformation.sparse_spinalldown_dm"
},

{
    "location": "api.html#QuantumInformation.hadamard",
    "page": "Basic functions",
    "title": "QuantumInformation.hadamard",
    "category": "function",
    "text": "   hadamard(n::Int=1)\n\nH^otimes n = frac1sqrt2^n beginbmatrix\n       1  1 \n       1  -1\nendbmatrix^otimes n\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.sgate",
    "page": "Basic functions",
    "title": "QuantumInformation.sgate",
    "category": "function",
    "text": "   sgate()\n\nS = sqrtsigma_z = beginbmatrix\n       1  0 \n       0  i\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.sdggate",
    "page": "Basic functions",
    "title": "QuantumInformation.sdggate",
    "category": "function",
    "text": "   sdggate()\n\nS^dagger = (sqrtsigma_z)^dagger = beginbmatrix\n       1  0 \n       0  -i\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.tgate",
    "page": "Basic functions",
    "title": "QuantumInformation.tgate",
    "category": "function",
    "text": "   tgate()\n\nT = beginbmatrix\n       1  0 \n       0  exp(i pi4)\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.tdggate",
    "page": "Basic functions",
    "title": "QuantumInformation.tdggate",
    "category": "function",
    "text": "   tdggate()\n\nT^dagger = beginbmatrix\n       1  0 \n       0  exp(- i pi4)\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.phaseshift",
    "page": "Basic functions",
    "title": "QuantumInformation.phaseshift",
    "category": "function",
    "text": "   phaseshift(λ)\n\nConstruct phase shift gate. λ must be real number. This is equivalent to singleunitary(0, 0, λ).\n\nU(lambda) = beginbmatrix\n       1  0 \n       0  e^i lambda\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.singleunitary",
    "page": "Basic functions",
    "title": "QuantumInformation.singleunitary",
    "category": "function",
    "text": "   singleunitary(θ, ϕ, λ)\n\nSingle qubit unitary gate.\n\nU(theta phi lambda) = beginbmatrix\n       cos(theta2)  -e^i lambdasin(theta2) \n       e^i phisin(theta2)  e^i (lambda + phi) cos(theta2)\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.controlsgate",
    "page": "Basic functions",
    "title": "QuantumInformation.controlsgate",
    "category": "function",
    "text": "   controlsgate(N, controls, target, op)\n\nConstruct multiple controlled gate. (Image: controlled gate)\n\nArguments\n\nN::Int: the number of qubits.\ncontrols::Vector{Int}: list of controlled qubit positions.\ntarget::Int: position of target qubit.\nop::Operator: Operator that acts on target qubit.\n\nExample\n\njulia> nqubits, controls, target, op = 3, [1, 2], 3, sigmax();\n\njulia> controlsgate(nqubits, controls, target, op) # equivalent to toffoli gate\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [3, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n  [5, 5]  =  1.0+0.0im\n  [6, 6]  =  1.0+0.0im\n  [8, 7]  =  1.0+0.0im\n  [7, 8]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.cnot",
    "page": "Basic functions",
    "title": "QuantumInformation.cnot",
    "category": "function",
    "text": "   cnot(N::Int=2, control::Int=1, target::Int=2)\n\nExample\n\njulia> cnot()\nSparseOperator(dim=4x4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [4, 3]  =  1.0+0.0im\n  [3, 4]  =  1.0+0.0im\n\njulia> nqubits, control, target = 3, 1, 3;\n\njulia> cnot(nqubits, control, target)\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [3, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n  [6, 5]  =  1.0+0.0im\n  [5, 6]  =  1.0+0.0im\n  [8, 7]  =  1.0+0.0im\n  [7, 8]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.toffoli",
    "page": "Basic functions",
    "title": "QuantumInformation.toffoli",
    "category": "function",
    "text": "   toffoli(N::Int=3, controls::Vector{Int}=[1, 2], target::Int=3)\n\nConstruct toffoli gate. (Image: toffoli gate)\n\nExample\n\njulia> toffoli() # equivalent to  toffoli(3, [1,2], 3)\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [3, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n  [5, 5]  =  1.0+0.0im\n  [6, 6]  =  1.0+0.0im\n  [8, 7]  =  1.0+0.0im\n  [7, 8]  =  1.0+0.0im\n\njulia> nqubits, controls, target = 4, [1,2], 3;\n\njulia> toffoli(nqubits, controls, target)\nSparseOperator(dim=16x16)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1 ,  1]  =  1.0+0.0im\n  [2 ,  2]  =  1.0+0.0im\n  [3 ,  3]  =  1.0+0.0im\n  [4 ,  4]  =  1.0+0.0im\n  [5 ,  5]  =  1.0+0.0im\n  [6 ,  6]  =  1.0+0.0im\n  [7 ,  7]  =  1.0+0.0im\n  [8 ,  8]  =  1.0+0.0im\n  [9 ,  9]  =  1.0+0.0im\n  [10, 10]  =  1.0+0.0im\n  [11, 11]  =  1.0+0.0im\n  [12, 12]  =  1.0+0.0im\n  [15, 13]  =  1.0+0.0im\n  [16, 14]  =  1.0+0.0im\n  [13, 15]  =  1.0+0.0im\n  [14, 16]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.swap",
    "page": "Basic functions",
    "title": "QuantumInformation.swap",
    "category": "function",
    "text": "   swap(N::Int=2, targets::Vector{Int}=[1,2])\n\nExapmle\n\njulia> swap()\nSparseOperator(dim=4x4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [3, 2]  =  1.0+0.0im\n  [2, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n\njulia> swap(3, [1,2])\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [5, 3]  =  1.0+0.0im\n  [6, 4]  =  1.0+0.0im\n  [3, 5]  =  1.0+0.0im\n  [4, 6]  =  1.0+0.0im\n  [7, 7]  =  1.0+0.0im\n  [8, 8]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#Quantum-Gate-1",
    "page": "Basic functions",
    "title": "Quantum Gate",
    "category": "section",
    "text": "QuantumInformation.hadamard\nQuantumInformation.sgate\nQuantumInformation.sdggate\nQuantumInformation.tgate\nQuantumInformation.tdggate\nQuantumInformation.phaseshift\nQuantumInformation.singleunitary\nQuantumInformation.controlsgate\nQuantumInformation.cnot\nQuantumInformation.toffoli\nQuantumInformation.swap"
},

]}
