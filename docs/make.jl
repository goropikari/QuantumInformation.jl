using Documenter, QuantumInformation

makedocs(
    format=:html,
    sitename="QuantumInformation.jl",
    modules=[QuantumInformation],
    pages=["index.md", "api.md"]
)

deploydocs(
    repo="github.com/goropikari/QuantumInformation.jl.git",
    julia="0.6",
    target="build",
    osname = "linux",
    deps=nothing,
    make=nothing
)
