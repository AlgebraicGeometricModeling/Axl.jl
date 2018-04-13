try Pkg.installed("SemiAlgebraicTypes")
catch;
    Pkg.clone("https://gitlab.inria.fr/AlgebraicGeometricModeling/SemiAlgebraicTypes.jl.git")
end

try run(`which axl`)
catch;
    using Conda
    Conda.add_channel("axl-distrib")
    Conda.add("axl")
end
