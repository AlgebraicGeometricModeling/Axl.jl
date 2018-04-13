# Readers

## Axl reader
It is possible to read `Axl` files and get the list of geometric objects contains in these files, using the function `axlread`.

```@docs
axlread
```

Here is an example of objects saved in the file `tmp.axl` with the command `@axlview` and read with the function `axlread`. 

```julia
s = sphere(point(0.,1.,0.), 0.5, color=Color(255,0,0))
c = cube(point(0.,0.,0.), 0.5, field=[Float64(i) for i in 1:8])
@axlview s,c
l = axlread("tmp.axl")
```
The list `l` contains a copy of the sphere `s` and of the mesh `c`.



## Obj reader

```@docs
objread
```
