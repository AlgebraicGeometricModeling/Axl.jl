#import Pkg

# try using SemiAlgebraicTypes
# catch;
#     Pkg.add(PackageSpec(url="https://gitlab.inria.fr/AlgebraicGeometricModeling/SemiAlgebraicTypes.jl.git"))
# end

try run(`which axl`)

    @info "axl installed
  Documentation: http://axl.inria.fr/doc/Axl.jl/"

catch;
    @warn "axl does not seems to be installed
  It can be installed with conda: \"conda install axl -c axel-distrib\"
  see http://axl.inria.fr/installation.html"

#    using Conda
#    Conda.add_channel("axel-distrib")
#    Conda.add("axl")
end

