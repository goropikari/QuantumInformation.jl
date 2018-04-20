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
    "text": "Pkg.clone(\"https://github.com/goropikari/QuantumInformation.jl\")"
},

{
    "location": "index.html#Basic-usage-1",
    "page": "QuantumInformation.jl Documentation",
    "title": "Basic usage",
    "category": "section",
    "text": "Make Bell state  psi rangle = frac12 ( 00 rangle +  11 rangle).julia> using QuantumInformation, QuantumInformation.ShortNames\n\njulia> ψ = qubit(\"00\")\nKet(dim=4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 1.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n 0.0+0.0im\n\njulia> ϕ = cnot() * (H() ⊗ id()) * ψ\nKet(dim=4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 0.707107+0.0im\n      0.0+0.0im\n      0.0+0.0im\n 0.707107+0.0im\n\njulia> tex(ϕ)\n|ψ> = 0.707|00> + 0.707|11>"
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
    "text": "Qubit ( SpinBasis(1//2) ) state can be rendered by MathJax(ASCII art) on IJulia(REPL).cnot() * (H() ⊗ id()) * qubit(\"00\")IJulia psi rangle = 0707  00 rangle+0707  11 rangleREPLjulia> cnot() * (H() ⊗ id()) * qubit(\"00\") |> tex\n|ψ> = 0.707|00> + 0.707|11>"
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
    "location": "api.html#Quantum-Gates-1",
    "page": "API",
    "title": "Quantum Gates",
    "category": "section",
    "text": "QuantumInformation.id\nQuantumInformation.sigmax\nQuantumInformation.sigmay\nQuantumInformation.sigmaz\nQuantumInformation.sigmap\nQuantumInformation.sigmam\nQuantumInformation.hadamard\nQuantumInformation.sgate\nQuantumInformation.sdggate\nQuantumInformation.tgate\nQuantumInformation.tdggate\nQuantumInformation.phaseshift\nQuantumInformation.singleunitary\nQuantumInformation.controlsgate\nQuantumInformation.cnot\nQuantumInformation.toffoli\nQuantumInformation.swap"
},

{
    "location": "api.html#QuantumInformation.tex",
    "page": "API",
    "title": "QuantumInformation.tex",
    "category": "function",
    "text": "tex(x, statename=\"ψ\") # for Ket and Bra\ntex(x, statename=\"Operator\") # for Operator\n\nLaTeX (ASCII art) rendering for qubits system\'s Ket, Bra, and Operator in IJulia (REPL). You can change LHS state name by second argument.\n\nExample (REPL)\n\njulia> id = identityoperator(SpinBasis(1//2));\n\njulia> ψ = cnot() * (hadamard() ⊗ id) * qubit(\"00\")\n\njulia> tex(ψ)\n|ψ> = 0.707|00> + 0.707|11>\n\njulia> dm(ψ)\nDenseOperator(dim=4x4)\n  basis: [Spin(1/2) ⊗ Spin(1/2)]\n 0.5+0.0im  0.0+0.0im  0.0+0.0im  0.5+0.0im\n 0.0+0.0im  0.0+0.0im  0.0+0.0im  0.0+0.0im\n 0.0+0.0im  0.0+0.0im  0.0+0.0im  0.0+0.0im\n 0.5+0.0im  0.0+0.0im  0.0+0.0im  0.5+0.0im\n\njulia> dm(ψ) |> tex\nOperator = 0.5 |00><00| +0.5 |00><11| +0.5 |11><00| +0.5 |11><11|\n\n\n\n"
},

{
    "location": "api.html#Printing-1",
    "page": "API",
    "title": "Printing",
    "category": "section",
    "text": "QuantumInformation.tex"
},

]}
