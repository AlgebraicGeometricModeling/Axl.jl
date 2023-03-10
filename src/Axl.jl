module Axl

using EzXML
using Reexport
@reexport using SemiAlgebraicTypes

Reader = Dict{String,Function}()

include("axlviewer.jl")
include("axlprint.jl")
include("axlread.jl")
include("objread.jl")
include("objprint.jl")
include("color.jl")
include("shapes.jl")
include("mesh.jl")
include("graph.jl")
include("dots.jl")
include("bspline.jl")

export @axl, @axlview, axlsave

AXLVIEW = Axl.axlviewer()
"""
Initiliaze an Axl view, or add objects to the view or visualize using Axl viewer.
```
@axl start
@axl O = point(0.,0.,0.)
A = point(1.,0.,0.); S = sphere(A, 0.5, color=Color(255,0,0)); @axl A,S
@axl view
```
"""
macro axl(arg)
    if arg == :view
        reset(AXLVIEW.io)
        mark(AXLVIEW.io)
        print(AXLVIEW.io,"</axl>\n")
        flush(AXLVIEW.io)
        wd=pwd()
        run(`axl $wd/tmp.axl \&`)
    elseif arg == :start
        Axl.init(AXLVIEW)
    else
        return quote
            reset(AXLVIEW.io)
            Axl.axlprint(AXLVIEW.io, $(esc(arg)), 2)
            mark(AXLVIEW.io)
            flush(AXLVIEW.io)
        end
    end
end

export AXLENV
AXLENV = Dict{Symbol,Any}( :size => 0.025, :opacity => 1.0, :rgb => "255 0 0")

export red, green ,blue, yellow, orange
red    = Color(255,0,0)
green  = Color(0,255,0)
blue   = Color(0,0,255)
yellow = Color(255,255,0)
orange = Color(255,100,0)


"""
Display a geometric object with Axl. If no argument is given, the last view is used if it exists.
```
@axlview A = point(1.,1.,1.)
A=point(1.,1.,0.); S=sphere(point(0.,0.,0.),0.5, color=color(255,0,0)); @axlview A,S
@axlview
```
"""
macro axlview(arg)
     quote
         Axl.init(AXLVIEW)
         Axl.axlprint(AXLVIEW.io, $(esc(arg)), 2)
         mark(AXLVIEW.io)
         print(AXLVIEW.io,"</axl>\n")
         flush(AXLVIEW.io)
         run(`axl tmp.axl`)
     end
end
#
macro axlview()
     reset(AXLVIEW.io)
     mark(AXLVIEW.io)
     print(AXLVIEW.io,"</axl>\n")
     flush(AXLVIEW.io)
     wd=pwd()
     run(`axl $wd/tmp.axl \&`)
end

function axlsave(file, arg...)
    Axl.init(AXLVIEW, file)
    Axl.axlprint(AXLVIEW.io, arg, 2)
    mark(AXLVIEW.io)
    print(AXLVIEW.io,"</axl>\n")
    flush(AXLVIEW.io)
end

end
