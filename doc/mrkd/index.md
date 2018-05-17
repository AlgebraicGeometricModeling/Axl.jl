# Axl.jl

The package allows to vizualise geometric objects with [Axl](http://axl.inria.fr/). It depends on the package `SemiAlgebraictypes.jl`, which provides the geometric objects.

## Geometric objects

The package handles the following types:

- point, line, sphere, cylinder, cone, ellipsoid, torus
- mesh with normals, fields
- bspline curve, surface, volume

## Installation 
To use this package, `julia` needs first to be installed (see [here](https://julialang.org/downloads/)).

The package can then be installed from `Julia` as follows:
```
Pkg.clone("https://gitlab.inria.fr/AlgebraicGeometricModeling/Axl.jl.git")
Pkg.build("Axl")
```
This installation checks that `axl` is installed. If not, it installs it using the Package `Conda`.
See [here](http://axl.inria.fr/installation.html) more details on how to install `axl`.

## Using `Axl.jl`
Here is an example of the visualization of a bspline surface:

```julia
using Axl

B1 = BSplineBasis(linspace(0., 2., 4), 3)
B2 = BSplineBasis(linspace(0., 1., 3), 3)

C = Array{Float64}(3,5,4)
for i in 1:5, j in 1:4
    C[:,i,j] = [i-1,j-1,5*rand()-2.5]
end
sf = BSplineSurface(C, B1,B2, color=Color(150,200,255))

@axlview sf

```
