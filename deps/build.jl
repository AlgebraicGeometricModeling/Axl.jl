try Pkg.installed("SemiAlgebraicTypes")
catch;
    Pkg.clone("https://gitlab.inria.fr/AlgebraicGeometricModeling/SemiAlgebraicTypes.jl.git")
end

try run(`which axl`)
catch;
    println("-- axl does not seems to be installed")
    println("-- see http://axl.inria.fr/installation.html")
#    using Conda
#    Conda.add_channel("axel-distrib")
#    Conda.add("axl")
#end
