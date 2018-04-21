__precompile__()

module QuantumInformation

# package code goes here
using QuantumOptics
import QuantumOptics: sigmam, sigmap, sigmax, sigmay, sigmaz
include("export.jl")

QuantumOptics.set_printing(standard_order=true)
# The reasons why the order of tensor product is inverted.
# https://github.com/qojulia/QuantumOptics.jl/blob/395f7077528d36bded0d5ef0652de19b5a9263db/src/printing.jl#L14-L24
# https://qojulia.org/documentation/quantumobjects/operators.html#tensor_order-1

include("basic.jl")
include("gates.jl")
include("printing.jl")

# Alternative Interface (`using QuantumInformation.ShortNames`)
module ShortNames
       using ..QuantumInformation
       include("export.jl")
       include("shortnames.jl")
end # ShortNames
using .ShortNames
end # module
