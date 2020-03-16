# Viewer

The objects in `SemiAlgebraicTypes` can be vizualized, using `Axl`. They are printed in a file `tmp.axl`
and Axl is then run on this view file.

```
@axl start
```
> Initialize the view file.


```
@axl m
```
> Add the object `m` to the viewfile.


```
@axl view
```
> Open `Axl` for visualization of the data in the view file. 
```
@axlview
```
> This is equivalent to `@axl view`.

```
@axlview m
```
> Save the object `m` in the viewfile and visualize it
    

## Example     
```
using Axl
@axl start
A = point(0.,0.5,0.)
B = point(0.,1.5,0.)
C = point(0.,3.5,0.)

@axl c0 = cylinder(A,B,0.2, color=Color(255,0,0))
@axl c1 = cone(C,B,0.7, color=Color(0,255,0))
@axl view

@axlview c0, sphere(A,0.5)
```




