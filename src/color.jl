export Color, DirField, dirfield, DistField, distfield
"""
Color represented by the `r`, `g`, `b` components (`Int64` between 0 and 255)  and a transparency component `t` (`Float64` between 0.0 and 1.0).
"""
mutable struct Color
    r::Int64
    g::Int64
    b::Int64
    t::Float64

    function Color(r::Int64, g::Int64, b::Int64, t::Float64=1.0)
        new(r,g,b,t)
    end
end

Reader["color"] = function(obj::EzXML.Node)
    @assert haskey(obj,"color") "No color attribute"
    c = split(obj["color"])
    if length(c)>3
        return Color(parse(Int64,c[1]),parse(Int64,c[2]),parse(Int64,c[3]),parse(Float64,c[4]))
    else
        return Color(parse(Int64,c[1]),parse(Int64,c[2]),parse(Int64,c[3]))
    end
end

"""
Scalar field described by a vector `dir`. The field value at a point is obtained by taking the scalar product with the vector.
"""
mutable struct DirField
    dir::Vector{Float64}
    
    function DirField(x::Float64=1.0, y::Float64=0.0, z::Float64=0.0)
        new([x,y,z])
    end
end

function axlprintfield(io::IO, dir::DirField, idt::Int64)
    axlprint(io, "<field type=\"axlFieldSpatialCoordinates\">\n", idt)
    axlprint(io, "<parameter value=\"", idt+2)
    println(io, dir.dir[1], "\" channel=\"0\" type=\"double\"/>")
    axlprint(io, "<parameter value=\"", idt+2)
    println(io, dir.dir[2], "\" channel=\"1\" type=\"double\"/>")
    axlprint(io, "<parameter value=\"", idt+2)
    println(io, dir.dir[3], "\" channel=\"2\" type=\"double\"/>")
    axlprint(io, "</field>\n", idt)
end

"""
Scalar field described by the point `pt`. The field value at a point is obtained by computing the distance to the point `pt`.
"""
mutable struct DistField
    pt::Vector{Float64}
    function DistField(x::Float64=0.0, y::Float64=0.0, z::Float64=0.0)
        new([x,y,z])
    end
end

function axlprintfield(io::IO, dist::DistField, idt::Int64)
    axlprint(io, "<field type=\"axlFieldSpatialPointDistance\">\n", idt)
    axlprint(io, "<input  xcoordinate=\"", idt+2);
    println(io, dist.pt[1], "\" ycoordinate=\"", dist.pt[2], "\" zcoordinate=\"", dist.pt[3], "\"/>")
    axlprint(io, "</field>\n", idt)
end


function axlprintfield(io::IO, V::Vector, idt::Int64)
    axlprint(io, "<field type=\"axlFieldDiscrete\" count=\"", idt)
    println(io, length(V), "\" dimension=\"1\" support=\"point\">")
    for v in V
        axlprint(io, v, idt+2); 
    end
    axlprint(io, "</field>\n", idt)
end
