The package `Axl.jl` is for the connection between Axl and Julia. 

The algebraic-geometric modeler `axl`should be installed (see [axl.inria.fr](http://axl.inria.fr)). 

## Installation
    
To install the package within julia:

```julia
Pkg.clone("https://gitlab.inria.fr/AlgebraicGeometricModeling/Axl.jl.git")
Pkg.build("Axl")
```
## Usage
Here is an example with a cylinder, a cone and a mesh:

```julia
using Axl

@axl start
@axl A = point(0.,0.5,0.)
@axl B = point(0.,1.5,0.)
C = point(0.,3.5,0.)

c0 = cylinder(A,B,0.2, color=Color(255,0,0))
c1 = cone(C,B,0.7, color=Color(0,255,0))

@axl c0, c1
@axl m = mesh([[cos(i*pi/5), sin(i*pi/5), 0.0] for i in 1:10], Edge[], [[1,i,i+1] for i in 1:9], field = DirField(1.,0.,0.))

@axl view
```

## Documentation

- [LATEST](http://axl.inria.fr/doc/Axl.jl/)
- For more information on [Julia](https://julialang.org/)
