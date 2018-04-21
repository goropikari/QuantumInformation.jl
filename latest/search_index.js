var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "QuantumInformation.jl Documentation",
    "title": "QuantumInformation.jl Documentation",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#QuantumInformation.jl-Documentation-1",
    "page": "QuantumInformation.jl Documentation",
    "title": "QuantumInformation.jl Documentation",
    "category": "section",
    "text": "QuantumInformation.jl is a package for learning quantum computation. I add quantum gates to QuantumOptics.jl."
},

{
    "location": "index.html#Installation-1",
    "page": "QuantumInformation.jl Documentation",
    "title": "Installation",
    "category": "section",
    "text": "Install QuantumInformation.jl within Julia usingPkg.clone(\"https://github.com/goropikari/QuantumInformation.jl\")"
},

{
    "location": "index.html#Getting-Started-1",
    "page": "QuantumInformation.jl Documentation",
    "title": "Getting Started",
    "category": "section",
    "text": "We start this tutorial with a very simple example that creats a Bell state,  psi rangle = frac12 ( 00 rangle +  11 rangle).julia> using QuantumInformation.ShortNames\n\njulia> ψ = qubit(\"00\") # prepare |00> state\nKet(dim=4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 1.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n\njulia> ϕ = cnot() * (H() ⊗ id()) * ψ # apply hadamard gate on first qubit and then apply CNOT gate.\nKet(dim=4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 0.707107+0.0im\n      0.0+0.0im\n      0.0+0.0im\n 0.707107+0.0im\n\njulia> tex(ϕ) # print braket form.\n|ψ⟩ = 0.707|00⟩ + 0.707|11⟩"
},

{
    "location": "example.html#",
    "page": "Examples",
    "title": "Examples",
    "category": "page",
    "text": ""
},

{
    "location": "example.html#Examples-1",
    "page": "Examples",
    "title": "Examples",
    "category": "section",
    "text": "Sample Jupyter notebooks are located on examples directory.Quantum teleportation\nLaTeX rendering"
},

{
    "location": "latex.html#",
    "page": "LaTeX rendering",
    "title": "LaTeX rendering",
    "category": "page",
    "text": ""
},

{
    "location": "latex.html#\\LaTeX-rendering-1",
    "page": "LaTeX rendering",
    "title": "LaTeX rendering",
    "category": "section",
    "text": "Qubit ( SpinBasis(1//2) ) state can be rendered by MathJax(ASCII art) on IJulia(REPL).cnot() * (H() ⊗ id()) * qubit(\"00\") |> texIJulia psi rangle = 0707  00 rangle+0707  11 rangleREPLjulia> cnot() * (H() ⊗ id()) * qubit(\"00\") |> tex\n|ψ> = 0.707|00> + 0.707|11>"
},

{
    "location": "api.html#",
    "page": "API",
    "title": "API",
    "category": "page",
    "text": ""
},

{
    "location": "api.html#API-1",
    "page": "API",
    "title": "API",
    "category": "section",
    "text": ""
},

{
    "location": "api.html#QuantumInformation.qubit",
    "page": "API",
    "title": "QuantumInformation.qubit",
    "category": "function",
    "text": "qubit(x)\n\nPrepare n-qubit state from binary.\n\nExample\n\njulia> qubit(\"010\")\nKet(dim=8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n 0.0+0.0im\n 0.0+0.0im\n 1.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.ghz",
    "page": "API",
    "title": "QuantumInformation.ghz",
    "category": "function",
    "text": "   ghz(n)\n\nn qubits GHZ(Greenberger–Horne–Zeilinger) state\n\n mathrmGHZ rangle = frac 0 rangle^otimes n +  1 rangle^otimes nsqrt2\n\nExample\n\njulia> n = 3;\n\njulia> ghz(n)\nKet(dim=8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n 0.707107+0.0im\n      0.0+0.0im\n      0.0+0.0im\n      0.0+0.0im\n      0.0+0.0im\n      0.0+0.0im\n      0.0+0.0im\n 0.707107+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.outer",
    "page": "API",
    "title": "QuantumInformation.outer",
    "category": "function",
    "text": "outer(x::Ket, y::Ket)\n\nConstruct outer product from two kets, xy.\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.inner",
    "page": "API",
    "title": "QuantumInformation.inner",
    "category": "function",
    "text": "inner(x::Ket, y::Ket)\n\nCalculate inner product from two kets, xy.\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.measure",
    "page": "API",
    "title": "QuantumInformation.measure",
    "category": "function",
    "text": "measure(state, n)\n\nProjective measurement with standard basis. Measure n th qubit w.r.t standard basis.\n\nReturn outcome (0 or 1) and post-meamurement state\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.sparse_spinallup_dm",
    "page": "API",
    "title": "QuantumInformation.sparse_spinallup_dm",
    "category": "function",
    "text": "sparse_spinallup_dm(n)\n\nn qubits all up state density matrix\n\n 0 rangle langle 0 ^otimes n\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.sparse_spinalldown_dm",
    "page": "API",
    "title": "QuantumInformation.sparse_spinalldown_dm",
    "category": "function",
    "text": "sparse_spinalldown_dm(n)\n\nn qubits all down state density matrix\n\n 1 rangle langle 1 ^otimes n\n\n\n\n"
},

{
    "location": "api.html#Basic-functions-1",
    "page": "API",
    "title": "Basic functions",
    "category": "section",
    "text": "QuantumInformation.qubit\nQuantumInformation.ghz\nQuantumInformation.outer\nQuantumInformation.inner\nQuantumInformation.measure\nQuantumInformation.sparse_spinallup_dm\nQuantumInformation.sparse_spinalldown_dm"
},

{
    "location": "api.html#QuantumInformation.ShortNames.id",
    "page": "API",
    "title": "QuantumInformation.ShortNames.id",
    "category": "function",
    "text": "id(n=1)\n\nIdentity operator for n qubits system.\n\n\n\n"
},

{
    "location": "api.html#QuantumOptics.spin.sigmax",
    "page": "API",
    "title": "QuantumOptics.spin.sigmax",
    "category": "function",
    "text": "\n\n   sigmax()\n\nsigma_x = beginbmatrix\n       0  1 \n       1  0\nendbmatrix\n\n\n\nsigmax(b::SpinBasis)\n\nPauli _x operator for the given Spin basis.\n\n\n\n"
},

{
    "location": "api.html#QuantumOptics.spin.sigmay",
    "page": "API",
    "title": "QuantumOptics.spin.sigmay",
    "category": "function",
    "text": "\n\n   sigmay()\n\nsigma_y = beginbmatrix\n       0  -i \n       i  0\nendbmatrix\n\n\n\nsigmay(b::SpinBasis)\n\nPauli _y operator for the given Spin basis.\n\n\n\n"
},

{
    "location": "api.html#QuantumOptics.spin.sigmaz",
    "page": "API",
    "title": "QuantumOptics.spin.sigmaz",
    "category": "function",
    "text": "\n\n   sigmaz()\n\nsigma_z = beginbmatrix\n       1  0 \n       0  -1\nendbmatrix\n\n\n\nsigmaz(b::SpinBasis)\n\nPauli _z operator for the given Spin basis.\n\n\n\n"
},

{
    "location": "api.html#QuantumOptics.spin.sigmap",
    "page": "API",
    "title": "QuantumOptics.spin.sigmap",
    "category": "function",
    "text": "\n\n   sigmap()\n\nsigma_+ =  0 rangle langle 1  = beginbmatrix\n       0  1 \n       0  0\nendbmatrix\n\n\n\nsigmap(b::SpinBasis)\n\nRaising operator _+ for the given Spin basis.\n\n\n\n"
},

{
    "location": "api.html#QuantumOptics.spin.sigmam",
    "page": "API",
    "title": "QuantumOptics.spin.sigmam",
    "category": "function",
    "text": "\n\n   sigmam()\n\nsigma_- =  1 rangle langle 0  = beginbmatrix\n       0  0 \n       1  0\nendbmatrix\n\n\n\nsigmam(b::SpinBasis)\n\nLowering operator _- for the given Spin basis.\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.hadamard",
    "page": "API",
    "title": "QuantumInformation.hadamard",
    "category": "function",
    "text": "   hadamard(n::Int=1)\n\nn tensor product Hadamard gate.\n\nH^otimes n = frac1sqrt2^n beginbmatrix\n       1  1 \n       1  -1\nendbmatrix^otimes n\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.sgate",
    "page": "API",
    "title": "QuantumInformation.sgate",
    "category": "function",
    "text": "   sgate()\n\nS = sqrtsigma_z = beginbmatrix\n       1  0 \n       0  i\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.sdggate",
    "page": "API",
    "title": "QuantumInformation.sdggate",
    "category": "function",
    "text": "   sdggate()\n\nS^dagger = (sqrtsigma_z)^dagger = beginbmatrix\n       1  0 \n       0  -i\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.tgate",
    "page": "API",
    "title": "QuantumInformation.tgate",
    "category": "function",
    "text": "   tgate()\n\nT = beginbmatrix\n       1  0 \n       0  exp(i pi4)\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.tdggate",
    "page": "API",
    "title": "QuantumInformation.tdggate",
    "category": "function",
    "text": "   tdggate()\n\nT^dagger = beginbmatrix\n       1  0 \n       0  exp(- i pi4)\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.phaseshift",
    "page": "API",
    "title": "QuantumInformation.phaseshift",
    "category": "function",
    "text": "   phaseshift(λ)\n\nPhase shift gate. λ must be real number. This is equivalent to singleunitary(0, 0, λ).\n\nU(lambda) = beginbmatrix\n       1  0 \n       0  e^i lambda\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.singleunitary",
    "page": "API",
    "title": "QuantumInformation.singleunitary",
    "category": "function",
    "text": "   singleunitary(θ, ϕ, λ)\n\nSingle qubit unitary gate.\n\nU(theta phi lambda) = beginbmatrix\n       cos(theta2)  -e^i lambdasin(theta2) \n       e^i phisin(theta2)  e^i (lambda + phi) cos(theta2)\nendbmatrix\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.controlsgate",
    "page": "API",
    "title": "QuantumInformation.controlsgate",
    "category": "function",
    "text": "   controlsgate(N, controls, target, op)\n\nMultiple controlled gate. (Image: controlled gate)\n\nArguments\n\nN::Int: the number of qubits.\ncontrols::Vector{Int}: list of controlled qubit positions.\ntarget::Int: position of target qubit.\nop::Operator: Operator that acts on target qubit.\n\nExample\n\njulia> nqubits, controls, target, op = 3, [1, 2], 3, sigmax();\n\njulia> controlsgate(nqubits, controls, target, op) # equivalent to toffoli gate\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [3, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n  [5, 5]  =  1.0+0.0im\n  [6, 6]  =  1.0+0.0im\n  [8, 7]  =  1.0+0.0im\n  [7, 8]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.cnot",
    "page": "API",
    "title": "QuantumInformation.cnot",
    "category": "function",
    "text": "   cnot(N::Int=2, control::Int=1, target::Int=2)\n\nArguments\n\nN::Int: the number of qubits.\ncontrol::Int: position of control qubit.\ntarget::Int: position of target qubit.\n\nExample\n\njulia> cnot()\nSparseOperator(dim=4x4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [4, 3]  =  1.0+0.0im\n  [3, 4]  =  1.0+0.0im\n\njulia> nqubits, control, target = 3, 1, 3;\n\njulia> cnot(nqubits, control, target)\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [3, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n  [6, 5]  =  1.0+0.0im\n  [5, 6]  =  1.0+0.0im\n  [8, 7]  =  1.0+0.0im\n  [7, 8]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.toffoli",
    "page": "API",
    "title": "QuantumInformation.toffoli",
    "category": "function",
    "text": "   toffoli(N::Int=3, controls::Vector{Int}=[1, 2], target::Int=3)\n\nToffoli gate. (Image: toffoli gate)\n\nExample\n\njulia> toffoli() # equivalent to  toffoli(3, [1,2], 3)\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [3, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n  [5, 5]  =  1.0+0.0im\n  [6, 6]  =  1.0+0.0im\n  [8, 7]  =  1.0+0.0im\n  [7, 8]  =  1.0+0.0im\n\njulia> nqubits, controls, target = 4, [1,2], 3;\n\njulia> toffoli(nqubits, controls, target)\nSparseOperator(dim=16x16)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1 ,  1]  =  1.0+0.0im\n  [2 ,  2]  =  1.0+0.0im\n  [3 ,  3]  =  1.0+0.0im\n  [4 ,  4]  =  1.0+0.0im\n  [5 ,  5]  =  1.0+0.0im\n  [6 ,  6]  =  1.0+0.0im\n  [7 ,  7]  =  1.0+0.0im\n  [8 ,  8]  =  1.0+0.0im\n  [9 ,  9]  =  1.0+0.0im\n  [10, 10]  =  1.0+0.0im\n  [11, 11]  =  1.0+0.0im\n  [12, 12]  =  1.0+0.0im\n  [15, 13]  =  1.0+0.0im\n  [16, 14]  =  1.0+0.0im\n  [13, 15]  =  1.0+0.0im\n  [14, 16]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#QuantumInformation.swap",
    "page": "API",
    "title": "QuantumInformation.swap",
    "category": "function",
    "text": "   swap(N::Int=2, targets::Vector{Int}=[1,2])\n\nExapmle\n\njulia> swap()\nSparseOperator(dim=4x4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [3, 2]  =  1.0+0.0im\n  [2, 3]  =  1.0+0.0im\n  [4, 4]  =  1.0+0.0im\n\njulia> swap(3, [1,2])\nSparseOperator(dim=8x8)\n  basis: [Spin(1/2) ⊗ Spin(1/2) ⊗ Spin(1/2)]\n  [1, 1]  =  1.0+0.0im\n  [2, 2]  =  1.0+0.0im\n  [5, 3]  =  1.0+0.0im\n  [6, 4]  =  1.0+0.0im\n  [3, 5]  =  1.0+0.0im\n  [4, 6]  =  1.0+0.0im\n  [7, 7]  =  1.0+0.0im\n  [8, 8]  =  1.0+0.0im\n\n\n\n"
},

{
    "location": "api.html#Quantum-Gates-1",
    "page": "API",
    "title": "Quantum Gates",
    "category": "section",
    "text": "QuantumInformation.ShortNames.id\nQuantumInformation.sigmax\nQuantumInformation.sigmay\nQuantumInformation.sigmaz\nQuantumInformation.sigmap\nQuantumInformation.sigmam\nQuantumInformation.hadamard\nQuantumInformation.sgate\nQuantumInformation.sdggate\nQuantumInformation.tgate\nQuantumInformation.tdggate\nQuantumInformation.phaseshift\nQuantumInformation.singleunitary\nQuantumInformation.controlsgate\nQuantumInformation.cnot\nQuantumInformation.toffoli\nQuantumInformation.swap"
},

{
    "location": "api.html#QuantumInformation.tex",
    "page": "API",
    "title": "QuantumInformation.tex",
    "category": "function",
    "text": "tex(x, statename=\"ψ\") # for Ket and Bra\ntex(x, statename=\"Operator\") # for Operator\n\nLaTeX (ASCII art) rendering for qubits system\'s Ket, Bra, and Operator in IJulia (REPL). You can change LHS state name by second argument.\n\nExample (REPL)\n\nulia> using QuantumInformation.ShortNames\n\njulia> ψ = cnot() * (H() ⊗ id()) * qubit(\"00\")\nKet(dim=4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 0.707107+0.0im\n      0.0+0.0im\n      0.0+0.0im\n 0.707107+0.0im\n\njulia> tex(ψ)\n|ψ⟩ = 0.707|00⟩ + 0.707|11⟩\n\njulia> dm(ψ)\nDenseOperator(dim=4x4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 0.5+0.0im  0.0+0.0im  0.0+0.0im  0.5+0.0im\n 0.0+0.0im  0.0+0.0im  0.0+0.0im  0.0+0.0im\n 0.0+0.0im  0.0+0.0im  0.0+0.0im  0.0+0.0im\n 0.5+0.0im  0.0+0.0im  0.0+0.0im  0.5+0.0im\n\njulia> dm(ψ) |> tex\nOperator = 0.5 |00⟩⟨00| +0.5 |00⟩⟨11| +0.5 |11⟩⟨00| +0.5 |11⟩⟨11|\n\n\n\n"
},

{
    "location": "api.html#Printing-1",
    "page": "API",
    "title": "Printing",
    "category": "section",
    "text": "QuantumInformation.tex"
},

]}
