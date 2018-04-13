export axlprint, indent

import Base: print

function indent(io::IO, idt::Int64)
    for i in 1:idt print(io," ") end
end

function axlprint(io::IO, T::Tuple, idt::Int64=0)
    for t in T
        axlprint(io,t,idt)
    end
end

function axlprint(io::IO, s::String, idt::Int64=0)
    indent(io, idt)
    print(io, s)
end

function axlprinttag(io::IO, X, tag::String, idt::Int64=0)
    indent(io, idt)
    print(io, "<",tag,">")
    print(io, X)
    print(io, "</",tag,">\n")
end

function axlprint(io::IO, c::C, idt::Int64=0) where {C<:Real}
    indent(io, idt)
    print(io, c)
end

function axlprint(io::IO, L::Vector{C}, idt::Int64=0) where {C <: Real}
    indent(io, idt)
    for l in L
        axlprint(io, l,1)
    end
end

function axlprint(io::IO, L::Vector, idt::Int64=0)
    for l in L
        axlprint(io, l,idt)
    end
end

function print(io::IO, P::Vector, idt::Int64=0)
    indent(io, idt)
    for i in 1:length(P)-1
        print(io,P[i]," ")
    end
    print(io,P[length(P)]," ")
end

function axlprintattr(io::IO, M)
    if isa(M[:color],Color)
        color = M[:color]
        print(io, " color=\"", color.r, " ", color.g, " ", color.b, " ", color.t,"\"")
    end
    if M[:size] !=0
        print(io, " size=\"", M[:size],"\"")
    end
end
