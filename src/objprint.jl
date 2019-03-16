export objprint

"""
Print a mesh in an obj file.
```
objprint(m, "file.obj")
```
"""
function objprint(m,file)
    io = open(file,"w")
    
    for i in 1:length(m.points[1,:])
        print(io,"v ",m.points[:,i],"\n")
    end
    
    for i in 1:length(m.faces)
        print(io,"f ",m.faces[i],"\n")
    end
    close(io)
end
