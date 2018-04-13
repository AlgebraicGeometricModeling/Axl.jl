# Bspline curves and surfaces
```julia
using Axl

B1 = BSplineBasis(linspace(0., 2., 4), 3)
B2 = BSplineBasis(linspace(0., 1., 3), 3)

C1 = [rand()*j^2/10. for i in 1:3, j in 1:5]
f1 = BSplineCurve(C1, B1, color=Color(255,0,0))

C2 = [rand()*j*k^2/20 for i in 1:3, j in 1:5, k in 1:4]
f2 = BSplineSurface(C2, B1,B2, color=Color(100,200,255))

@axlview f1,f2
```
