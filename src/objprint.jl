export objread

"""
Read an obj file and ouput a mesh.
```
objread("file.obj")
```
"""
function objprint(m,file)
    io = open(file,"w")
    #m = mesh(Float64)
    
   for i in 1:length(m.points[1,:])
   print(io,"v ",m.points[:,i],"\n")
   end
   
   for i in 1:length(m.faces)
   print(io,"f ",m.faces[i],"\n")
   end
   close(io)
    m
end
