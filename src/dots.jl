export dots, dotsupport
using SparseArrays

#import DynamicPolynomials: variables

"""
Output the array of complex values as a mesh of points in the plane.
```
dots(rand(Complex{Float64},100),color=color(0,100,155),size=0.7)
```
"""
function dots(L::Vector{Complex{Float64}}; args...)
    m = mesh(Float64)
    m[:size]=0.5
    m[:color]=Color(0,0,255)
    for c in L
        push_vertex!(m, point(real(c), imag(c) , 0.0))
    end
    for arg in args
        m[arg[1]]=arg[2]
    end
    return m
end

"""
Output the matrix entries as a mesh of points in the plane with the color map according to their absolute values.
If the absolute value of the entrie is smaller than eps (default value 1.e-6), it is not plot.
The entrie M[i,j] is put in position ((j-1)/(min(n1,n2)-1), (n1-i)/(min(n1,n2)-1)).
```
dots(rand(25,100))
dots(rand(25,100),0.2)
```
"""
function dots(M::Matrix{Float64}, eps = 1.e-6; args...)
    m = mesh(Float64)
    m[:size]=0.5
    n1 = size(M,1)
    n2 = size(M,2)
    n = min(n1,n2)
    C = Float64[]
    for i in 1:n1
        for j in 1:n2
            if abs(M[i,j]) > eps
                Axl.push_vertex!(m, point((j-1)/(n-1), (n1-1)/(n-1)-(i-1)/(n-1),  0.0))
                push!(C,abs(M[i,j]))
            end
        end
    end
    for arg in args m[arg[1]]=arg[2] end
    m[:field] = C
    return m
end

function dots(M::AbstractSparseMatrix{Float64,Int64}, eps = 1.e-6; args...)
    m = Axl.mesh(Float64)
    m[:size]=0.5
    n1 = size(M,1)
    n2 = size(M,2)
    n = min(n1,n2)
    C = Float64[]
    I,J, V=findnz(M)
    for l in 1:length(I)
        i = I[l]
        j = J[l]
        v = V[l]
        if abs(v) > eps
                Axl.push_vertex!(m, point((j-1)/(n-1), (n1-1)/(n-1)-(i-1)/(n-1),  0.0))
                push!(C,abs(v))
        end
    end
    for arg in args m[arg[1]]=arg[2] end
    m[:field] = C
    return m
end


"""
Output the support of polynomial as a mesh of points. Only the exponents of the first 3 variables in the monomials are used.
If the polynomial is with n variables, the mesh is in dimension min(n,3).
```
p = x^2 + y^2-1
dotsupport(p)
```
"""
function dotsupport(pol; args...)
    m = mesh(Float64)
    m[:size]=0.5
    m[:color]=Color(0,0,255)
    C = Float64[]
    for t in pol
        if length(t.x.z) >= 3
            Axl.push_vertex!(m, point(Float64(t.x.z[1]), Float64(t.x.z[2]), Float64(t.x.z[3])))
        elseif length(t.x.z) == 2
            Axl.push_vertex!(m, point(Float64(t.x.z[1]), Float64(t.x.z[2]), 0.0))
        elseif length(t.x.z) == 2
            Axl.push_vertex!(m, point(Float64(t.x.z[1]), 0.0, 0.0))
        end
        push!(C,abs(t.α))
    end
    for arg in args m[arg[1]]=arg[2] end
    m[:field] = C
    return m
end
