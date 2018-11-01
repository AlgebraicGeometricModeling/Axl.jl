export axlprint, axlreadmesh

import Base: push!, getindex, setindex!, print
#----------------------------------------------------------------------
function axlprint(io::IO, M::Mesh{T}, idt::Int64=0 ) where T

    axlprint(io, "<mesh",idt)
    axlprintattr(io,M)
    println(io, ">")
    axlprint(io, "<count>",idt); println(io, nbv(M)," ",nbe(M)," ",nbf(M),"</count>")
    axlprint(io, "<points>\n",idt)
    for i in 1:nbv(M)
        print(io, M.points[:,i], idt+2)
        println(io)
    end
    axlprint(io, "</points>\n", idt)
    if (nbe(M)>0)
        axlprint(io, "<edges>\n", idt)
        for i in 1:nbe(M)
            axlprint(io, length(M.edges[i]), idt+2)
            for j in 1:length(M.edges[i])
                print(io, " ", M.edges[i][j]-1)
            end
            println(io)
        end
        axlprint(io, "</edges>\n", idt)
    end
    if (nbf(M)>0)
        axlprint(io, "<faces>\n", idt)
        for i in 1:nbf(M)
            axlprint(io, length(M.faces[i]), idt+2)
            for j in 1:length(M.faces[i])
                print(io, " ", M.faces[i][j]-1)
            end
            println(io)
        end
        axlprint(io, "</faces>\n", idt)
    end
    if M[:field] != 0 axlprintfield(io,  M[:field], idt) end
    axlprint(io, "</mesh>\n", idt)
end

#----------------------------------------------------------------------
function Axl.axlprint(io::IO, M::HMesh, idt::Int64=0 )

    axlprint(io, "<mesh",idt)
    axlprintattr(io,M)
    println(io, ">")
    axlprint(io, "<count>",idt); println(io, nbv(M)," 0 ",nbf(M),"</count>")
    axlprint(io, "<points>\n",idt)
    for i in 1:nbv(M)
        print(io, M.points[:,i], idt+2)
        println(io)
    end
    axlprint(io, "</points>\n", idt)
    if (nbf(M)>0)
        axlprint(io, "<faces>\n", idt)
        for f in 1:nbf(M)
            E = edges_on_face(M,f)
            axlprint(io, length(E), idt+2)
            for e in E
                print(io, " ", edge(M,e).point-1)
            end
            println(io)
        end
        axlprint(io, "</faces>\n", idt)
    end
#    if M["field"] != 0 axlprintfield(io,  M["field"], idt) end
    axlprint(io, "</mesh>\n", idt)
end

#----------------------------------------------------------------------
Reader["mesh"] = function(obj::EzXML.Node)
    m = mesh(Float64)
    if haskey(obj, "size")
        m[:size]=parse(Float64, obj["size"])
    end
    for e in elements(obj)
        if nodename(e)=="count"
            n = map(x->parse(Int64,x), split(nodecontent(e)))
        elseif nodename(e)=="points"
            points = map(x->parse(Float64,x), split(nodecontent(e)))
            i = 0;
            while i < length(points)-2
                push_vertex!(m, [points[i+1],points[i+2],points[i+3]])
                i += 3
            end
        elseif nodename(e)=="edges"
            edges = map(x->parse(Int64,x), split(nodecontent(e)))
            i = 1;
            while i <= length(edges)
                s = edges[i]
                f = Int64[]
                for j in 1:s
                    push!(f, edges[i+j]+1)
                end
                push_edge!(m, f)
                i+= (s+1)
            end
        elseif nodename(e)=="faces"
            faces = map(x->parse(Int64,x), split(nodecontent(e)))
            i = 1;
            while i <= length(faces)
                s = faces[i]
                f = Int64[]
                for j in 1:s
                    push!(f, faces[i+j]+1)
                end
                push_face!(m, f)
                i+= (s+1)
            end
        elseif nodename(e)=="field"
            # check if the field is scalar
            C = Float64[]
            val = map(x->parse(Float64,x), split(nodecontent(e)))
            i = 1;
            for i in 1:length(val)
                push!(C, val[i])
            end
            m[:field] = C
        end
    end
    return m
end

