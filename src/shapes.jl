export axlprint

#----------------------------------------------------------------------
function axlprint(io::IO, V::Vector{T}, idt::Int64=0) where {T<:Real}
    axlprint(io, "<point size=\""*string(AXLENV[:size])*"\" color=\""*AXLENV[:rgb]*" "*string(AXLENV[:opacity])*"\"> ", idt)
    for l in V
         print(io, l, " ")
    end
    axlprint(io, "</point>\n")
end

function axlprint(io::IO, L::Line{T}, idt::Int64=0 ) where T
    axlprint(io, "<line",idt)
    axlprintattr(io, L)
    println(io, ">")

    axlprinttag(io, L.pt0, "point", idt+2)
    axlprinttag(io, L.pt1, "point", idt+2)
    axlprint(io, "</line>\n", idt)
end

Reader["line"] = function(obj::EzXML.Node)
    pts = Vector{Float64}[]
    for e in elements(obj)
        if nodename(e)=="point"
            push!(pts, map(x->parse(Float64,x), split(nodecontent(e))))
        end
    end
    l = line(pts[1],pts[2])
    axlsetattr!(l,obj)
    return l
end
#----------------------------------------------------------------------
function axlprint(io::IO, S::Sphere{T}, idt::Int64=0 ) where T
    axlprint(io, "<sphere", idt)
    axlprintattr(io, S)
    println(io, ">")
    axlprinttag(io, S.center, "center", idt+2)
    axlprinttag(io, S.radius, "radius",idt+2)
    if S[:field] != 0  axlprintfield(io, S[:field], idt)  end
    axlprint(io, "</sphere>\n", idt)
end

Reader["sphere"] = function(obj::EzXML.Node)
    p = Float64[]
    r = 0.0
    for e in elements(obj)
        if nodename(e)=="center"
            p = map(x->parse(Float64,x), split(nodecontent(e)))
        elseif nodename(e)=="radius"
            r = parse(Float64,nodecontent(e))
        end
    end
    s = sphere(p,r)
    axlsetattr!(s,obj)
    return s
end
#----------------------------------------------------------------------
function axlprint(io::IO, C::Cylinder{T}, idt::Int64=0 ) where T
    axlprint(io, "<cylinder", idt)
    axlprintattr(io,C)
    println(io, ">")
    axlprinttag(io, C.pt0, "point", idt+2)
    axlprinttag(io, C.pt1, "point", idt+2)
    axlprinttag(io, C.radius,"radius",idt+2)
    if C[:field] != 0 axlprintfield(io, C[:field], idt) end
    axlprint(io, "</cylinder>\n",idt)
end

Reader["cylinder"] = function(obj::EzXML.Node)
    pts = Vector{Float64}[]
    r = 0.0
    for e in elements(obj)
        if nodename(e)=="point"
            push!(pts, map(x->parse(Float64,x), split(nodecontent(e))))
        elseif nodename(e)=="radius"
            r = parse(Float64,nodecontent(e))
        end
    end
    c = cylinder(pts[1],pts[2],r)
    axlsetattr!(c,obj)
    return c
end
#----------------------------------------------------------------------
function axlprint(io::IO, C::Cone{T}, idt::Int64=0 ) where T
    axlprint(io, "<cone",idt)
    axlprintattr(io,C)
    println(io, ">")
    axlprinttag(io, C.pt0, "point", idt+2)
    axlprinttag(io, C.pt1, "point", idt+2)
    axlprinttag(io, C.radius,"radius", idt+2)
    if C[:field] != 0 axlprintfield(io,  C[:field], idt) end
    axlprint(io, "</cone>\n",idt)
end

Reader["cone"] = function(obj::EzXML.Node)
    pts = Vector{Float64}[]
    r = 0.0
    for e in elements(obj)
        if nodename(e)=="point"
            push!(pts, map(x->parse(Float64,x), split(nodecontent(e))))
        elseif nodename(e)=="radius"
            r = parse(Float64,nodecontent(e))
        end
    end
    c=cone(pts[1],pts[2],r)
    axlsetattr!(c,obj)
    return c
end
#----------------------------------------------------------------------
function axlprint(io::IO, E::Ellipsoid{T}, idt::Int64=0 ) where T
    axlprint(io, "<ellipsoid",idt)
    axlprintattr(io,E)
    println(io, ">")
    axlprinttag(io, E.c, "center", idt+2)
    axlprinttag(io, E.sx, "semix", idt+2)
    axlprinttag(io, E.sy, "semiy", idt+2)
    axlprinttag(io, E.sz, "semiz", idt+2)
    if E[:field] != 0 axlprintfield(io,  E[:field], idt) end
    axlprint(io, "</ellipsoid>\n",idt)
end

Reader["ellipsoid"] = function(obj::EzXML.Node)

    c = fill(0.0,3)
    sx = fill(0.0,3)
    sy = fill(0.0,3)
    sz = fill(0.0,3)

    for e in elements(obj)
        if nodename(e)=="center"
            c = map(x->parse(Float64,x), split(nodecontent(e)))
        elseif nodename(e)=="semix"
            sx = map(x->parse(Float64,x), split(nodecontent(e)))
        elseif nodename(e)=="semiy"
            sy = map(x->parse(Float64,x), split(nodecontent(e)))
        elseif nodename(e)=="semiz"
            sz = map(x->parse(Float64,x), split(nodecontent(e)))
        end
    end
    c = ellipsoid(c,sx,sy,sz)
    axlsetattr!(c,obj)
    return c
end
#----------------------------------------------------------------------

