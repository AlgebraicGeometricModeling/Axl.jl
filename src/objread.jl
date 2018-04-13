export objread

"""
Read an obj file and ouput a mesh.
```
objread("file.obj")
```
"""
#----------------------------------------------------------------------
function objread(file::String)
    io = open(file)
    m = mesh(Float64)
    for txt in eachline(io)
        l = split(txt, " ");
        if l[1] == "v"
        
            pt = Float64[]
            s = 0
            for i in 2:length(l)
                if length(l[i])>0 && !startswith(l[i]," ") && s<3
                    push!(pt,parse(Float64,l[i]))
                    

                    s+=1

                end
            end
            push_vertex!(m,pt)
            
        elseif l[1] == "vn"
            
            pt = Float64[]
            s = 0
            for i in 2:length(l)
                if length(l[i])>0 && !startswith(l[i]," ") && s<3
                    push!(pt,parse(Float64,l[i]))
                    

                    s+=1

                end
            end
           push_normal!(m,pt)
        elseif l[1] == "f"
            f = Int64[]
            for i in 2:length(l)

                if length(l[i])>0 && !startswith(l[i]," ") 
                    push!(f, parse(Int64, split(split(l[i],"//")[1],"/")[1]  ))
                    

                end
            end
            push_face!(m,f)
        end

    end
    close(io)
    m
end
