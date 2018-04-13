using EzXML
export axlread

function Base.getindex(r::Dict{String,Function}, s::String) get(r, s, 0) end

"""
Read an axl file and ouput the list of objets:
```
axlread("file.axl")
```
The function uses the table `Axl.Reader::Dict{String,Function}` to determine how to read 
the elements in the file.
The functions needed to read an object of a given type "key" are defined as follows:
```
Reader["key"] = function(obj::EzXML.Node) ... end
```
If the element `obj` has a key `type` then the reader `Reader[obj["type"]]` is used,
otherwise the reader `Reader[nodename(obj)]` is used.
"""
function axlread(file::String)
    doc = EzXML.readxml(file)
    r = []
    for obj in eachelement(root(doc))
        if haskey(obj, "type")
            read = Reader[obj["type"]]
            if read != 0
                push!(r, read(obj))
            end
        else
            read = Reader[nodename(obj)]
            if read != 0
                push!(r, read(obj))
            end
        end
    end
    r
end


function axlsetattr!(geo, obj::EzXML.Node)
    if haskey(obj, "size")
        geo[:size]=parse(Float64,obj["size"])
    end
    if haskey(obj,"color")
        geo[:color]=Reader["color"](obj)
    end
    if haskey(obj,"shader")
        geo[:shader]=obj["shader"]
    end
end
