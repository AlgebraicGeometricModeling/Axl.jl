export parametric, polar

"""
Plot the parametric surface f: (u,v) -> [x,y,z] for u in the interval X, v in the interval Y.
```
parametric((u,v)->[u,v,cos(2*u*v)], 0.0 => 2.0, -pi => pi, field=DistField(0.0,0.0,0.0))
```
"""
function parametric(f::Function, X::Pair, N::Int=50; args...)
    rx = LinRange(X.first,X.second,N)
    m = mesh(Float64)
    for x in rx
        push_vertex!(m,f(x))
    end
    push_edge!(m,[i for i in 1:N])

    for arg in args
        m[arg[1]]=arg[2]
    end
    return m
end


"""
Plot the parametric surface f: (u,v) -> [x,y,z] for u in the interval X, v in the interval Y.
```
parametric((u,v)->[u,v,cos(2*u*v)], 0.0 => 2.0, -pi => pi, field=DistField(0.0,0.0,0.0))
```
"""
function parametric(f::Function, X::Pair, Y::Pair, N::Int=50; args...)
    rx = LinRange(X.first,X.second,N)
    ry = LinRange(Y.first,Y.second,N)
    m = mesh(Float64)
    for x in rx
        for y in ry
            push_vertex!(m,f(x,y))
        end
    end
    for i in 1:N-1
        for j in 1:N-1
            push_face!(m,[(i-1)*N+(j-1)+1, (i-1)*N+(j)+1, (i)*N+(j)+1, (i)*N+j])
        end
    end
    for arg in args
        m[arg[1]]=arg[2]
    end
    return m
end

"""
Plot the radius function r = f(x,y,z) on the unitary sphere.
```
polar((x,y,z)->cos(x*y*z+1.0), 200, field=DistField())
```
"""
function polar(f::Function, N::Int64=50; args...)
    rx = LinRange(0.0, 2*pi, N)
    ry = LinRange(-pi/2, pi/2, N)
    m  = mesh(Float64)

    for x in rx
        for y in ry
            v = [cos(x)*cos(y), sin(x)*cos(y), sin(y)]
            v *= f(v[1], v[2], v[3])
            push_vertex!(m, v)
        end
    end
    for i in 1:N-1
        for j in 1:N-1
            push_face!(m,[(i)*N+j, (i)*N+(j)+1, (i-1)*N+(j)+1, (i-1)*N+(j-1)+1 ])
            #push_face!(m,[ (i-1)*N+(j-1)+1, (i-1)*N+(j)+1, (i)*N+(j)+1, (i)*N+j ])
        end
    end
    for arg in args
        m[arg[1]]=arg[2]
    end
    return m
end
