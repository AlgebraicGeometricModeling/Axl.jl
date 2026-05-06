# Parametrisations
```julia
using Axl

pol = polar((x,y,z)->cos(x*y*z+1.0), 200; color = Axl.green)
ver = parametric(t->[t,t^2,t^3], -1.0 => 1.0)
tgt = parametric((t,l) -> [t+l, t^2+2*l*t, t^3 + 3*l*t^2],  -1.0 => 1.0,  -0.5 => 0.5; color = Axl.red)

@axlview pol, ver, tgt
```
