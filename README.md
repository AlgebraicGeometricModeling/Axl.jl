The package `Axl.jl` is for the connection between Axl and Julia. 

The algebraic-geometric modeler `axl`should be installed (see [axl.inria.fr](http://axl.inria.fr)). 

## Installation

To install the package within julia:

```julia
using Pkg
Pkg.add(PackageSpec(url="https://gitlab.inria.fr/AlgebraicGeometricModeling/Axl.jl.git"))
Pkg.build("Axl")
```

The package depends on [`SemiAlgebraicTypes.jl`](https://gitlab.inria.fr/AlgebraicGeometricModeling/SemiAlgebraicTypes.jl).
    
## More information

- [Documentation](http://axl.inria.fr/doc/Axl.jl/)
- [Gitlab](https://gitlab.inria.fr/AlgebraicGeometricModeling/Axl.jl)
- [Julia](https://julialang.org/)
