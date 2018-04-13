export BSplineCurve, BSplineSurface, axlprint, axlreadbspline

mutable struct BSplineCurve
    map ::BSplineFunction1D
    attr::Dict{Symbol,Any}

    function BSplineCurve(points, knots, order, extend=true)
        map = BSplineFunction1D(points,knots,order,extend)
        new(map, Dict{Symbol,Any}())
    end

    function BSplineCurve(points, bs::BSplineBasis; args...)
        dict =  Dict{Symbol,Any}()
        for arg in args
            dict[arg[1]]=arg[2]
        end
        new( BSplineFunction1D(points, bs), dict)
    end

    function BSplineCurve(points, bs::BSplineBasis, dict::Dict{Symbol,Any})
        new( BSplineFunction1D(points, bs), dict)
    end
end

function Base.getindex(f::BSplineCurve, s::Symbol)  get(f.attr, s, 0) end
function Base.setindex!(f::BSplineCurve, v, s::Symbol)  f.attr[s] = v end


function axlprint(io::IO, f::BSplineCurve, idt::Int64 = 0)
    indent(io, idt);
    print(io, "<curve type=\"bspline\"")
    if isa(f[:color],Color)
        color = f[:color]
        print(io, " color=\"", color.r, " ", color.g, " ", color.b,"\"")
    end
    if f[:size] !=0
        print(io, " size=\"", f[:size],"\"")
    end
    println(io, ">")
    indent(io, idt+2); print(io, "<dimension>",size(f.map.points,1),"</dimension>\n")
    indent(io, idt+2); print(io, "<number>", size(f.map.points,2), "</number>\n")
    indent(io, idt+2); print(io, "<order>", f.map.basis.order, "</order>\n")
    indent(io, idt+2); print(io, "<knots>"); for t in f.map.basis.knots print(io," ",t) end; print(io,"</knots>\n")
    indent(io, idt+2); print(io, "<points>\n")
    for i in 1:size(f.map.points,2)
        print(io, f.map.points[:,i], idt+2)
        print(io,"\n")
    end
    indent(io, idt); print(io, "</points>\n")
    indent(io, idt); print(io, "</curve>\n")
end
#----------------------------------------------------------------------
mutable struct BSplineSurface
    map  ::BSplineFunction2D
    attr ::Dict{Symbol,Any}

    function BSplineSurface(points, bs1::BSplineBasis, bs2::BSplineBasis; args...)
        dict =  Dict{Symbol,Any}()
        for arg in args
            dict[arg[1]]=arg[2]
        end
        new(BSplineFunction2D(points,bs1,bs2), dict)
    end
    
    function BSplineSurface(points, bs1::BSplineBasis, bs2::BSplineBasis, dict::Dict{Symbol,Any})
        new(BSplineFunction2D(points, bs1, bs2), dict)
    end
end

function Base.getindex(f::BSplineSurface, s::Symbol)  get(f.attr, s, 0) end
function Base.setindex!(f::BSplineSurface, v, s::Symbol)  f.attr[s] = v end

#----------------------------------------------------------------------
function axlprint(io::IO, f::BSplineSurface, idt::Int64 = 0)
    indent(io, idt);
    print(io, "<surface type=\"bspline\"")
    if isa(f[:color],Color)
        color = f[:color]
        print(io, " color=\"", color.r, " ", color.g, " ", color.b,"\"")
    end
    if f[:size] !=0
        print(io, " size=\"", f[:size],"\"")
    end
    println(io, ">")
    indent(io, idt+2); print(io, "<dimension>",size(f.map.points,1),"</dimension>\n")
    indent(io, idt+2); print(io, "<number>", size(f.map.points,2)," ", size(f.map.points,3), "</number>\n")
    indent(io, idt+2); print(io, "<order>", f.map.basis1.order," ", f.map.basis2.order, "</order>\n")
    indent(io, idt+2); print(io, "<knots>"); for t in f.map.basis1.knots print(io," ",t) end; print(io,"</knots>\n")
    indent(io, idt+2); print(io, "<knots>"); for t in f.map.basis2.knots print(io," ",t) end; print(io,"</knots>\n")    
    indent(io, idt+2); print(io, "<points>\n")
    for  j in 1:size(f.map.points,3), i in 1:size(f.map.points,2)
        print(io, f.map.points[:,i,j], idt+2)
        print(io,"\n")
    end
    indent(io, idt); print(io, "</points>\n")
    indent(io, idt); print(io, "</surface>\n")
end


#----------------------------------------------------------------------
mutable struct BSplineVolume
    map  ::BSplineFunction3D
    attr ::Dict{Symbol,Any}

    function BSplineVolume(points, bs1::BSplineBasis, bs2::BSplineBasis, bs3::BSplineBasis; args...)
        dict =  Dict{Symbol,Any}()
        for arg in args
            dict[arg[1]]=arg[2]
        end
        new(BSplineFunction3D(points,bs1,bs2,bs3), dict)
    end
    
    function BSplineVolume(points, bs1::BSplineBasis, bs2::BSplineBasis, bs3::BSplineBasis, dict::Dict{Symbol,Any})
        new(BSplineFunction3D(points, bs1, bs2, bs3), dict)
    end
end

function Base.getindex(f::BSplineVolume, s::Symbol)  get(f.attr, s, 0) end
function Base.setindex!(f::BSplineVolume, v, s::Symbol)  f.attr[s] = v end

#----------------------------------------------------------------------
function axlprint(io::IO, f::BSplineVolume, idt::Int64 = 0)
    indent(io, idt);
    print(io, "<volume type=\"bspline\"")
    if isa(f[:color],Color)
        color = f[:color]
        print(io, " color=\"", color.r, " ", color.g, " ", color.b,"\"")
    end
    if f[:size] !=0
        print(io, " size=\"", f[:size],"\"")
    end
    println(io, ">")
    indent(io, idt+2); print(io, "<dimension>",size(f.map.points,1),"</dimension>\n")
    indent(io, idt+2); print(io, "<number>", size(f.map.points,2)," ", size(f.map.points,3), "</number>\n")
    indent(io, idt+2); print(io, "<order>", f.map.basis1.order," ", f.map.basis2.order, " ",f.map.basi3.order, "</order>\n")
    indent(io, idt+2); print(io, "<knots>"); for t in f.map.basis1.knots print(io," ",t) end; print(io,"</knots>\n")
    indent(io, idt+2); print(io, "<knots>"); for t in f.map.basis2.knots print(io," ",t) end; print(io,"</knots>\n")
     indent(io, idt+2); print(io, "<knots>"); for t in f.map.basis3.knots print(io," ",t) end; print(io,"</knots>\n") 
    indent(io, idt+2); print(io, "<points>\n")
    for  k in 1:szie(4,f.map.points), j in 1:size(f.map.points,3), i in 1:size(f.map.points,2)
        print(io, f.map.points[:,i,j,k], idt+2)
        print(io,"\n")
    end
    indent(io, idt); print(io, "</points>\n")
    indent(io, idt); print(io, "</volume>\n")
end


#----------------------------------------------------------------------
Reader["bspline"]=function(obj::EzXML.Node)
    n = 3
    sz = [1,1]
    orders=[1,1]
    knots = Vector{Float64}[]
    Pts = fill(0.0,0)
    dict =  Dict{Symbol,Any}()
    axlsetattr!(dict, obj)
    for e in elements(obj)
        if nodename(e)=="dimension"
            n = parse(Int64,nodecontent(e))
        elseif nodename(e)=="order"
            orders = map(x->parse(Int64,x), split(nodecontent(e)))
        elseif nodename(e)=="number"
            sz = map(x->parse(Int64,x), split(nodecontent(e)))
        elseif nodename(e)=="knots"
            k = map(x->parse(Float64,x), split(nodecontent(e)))
            push!(knots,k)
        elseif nodename(e)=="points"
            L = map(x->parse(Float64,x), split(nodecontent(e)))
            if nodename(obj)=="curve"
                Pts = fill(0.0, n, sz[1])
                for v in 1:n, i in 1:sz[1]
                    Pts[v,i] = L[v + n*(i-1)]
                end
            elseif nodename(obj)=="surface"
                Pts = fill(0.0, n, sz[1], sz[2])
                for  v in 1:n, i in 1:sz[1], j in 1:sz[2]
                    Pts[v,i,j] = L[v + n*(i-1) + n*sz[1]*(j-1)]
                end
            elseif nodename(obj)=="volume"
                Pts = fill(0.0, n, sz[1], sz[2], sz[3])
                for v in 1:n, i in 1:sz[1], j in 1:sz[2], k in 1:sz[3]
                    Pts[v,i,j,k] = L[v + n*(i-1) + n*sz[1]*(j-1) + n*sz[1]*sz[2]*(k-1)]
                end
            end
        end
    end
   
    
    if nodename(obj)=="curve"
        return BSplineCurve(Pts,
                            BSplineBasis(knots[1],orders[1],false),
                            dict)
    elseif nodename(obj)=="surface"
        return BSplineSurface(Pts,
                              BSplineBasis(knots[1],orders[1],false),
                              BSplineBasis(knots[2],orders[2],false),
                              dict)
    elseif nodename(obj)=="volume"
        return BSplineVolume(Pts,
                              BSplineBasis(knots[1],orders[1],false),
                              BSplineBasis(knots[2],orders[2],false),
                              BSplineBasis(knots[3],orders[3],false),
                              dict)
    end
end
