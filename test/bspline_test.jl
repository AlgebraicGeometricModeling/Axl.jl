using Axl

B1 = BSplineBasis(linspace(0., 2., 4), 3)
B2 = BSplineBasis(linspace(0., 1., 3), 3)

@assert length(B1) == 5
@assert length(B2) == 4

C1 = Array{Float64}(3,5)
for i in 1:5, j in 1:4
    C1[:,i] = [(i-1)/4,(i-1)/4,rand()]
end
f1 = BSplineCurve(C1, B1, color=Color(255,0,0))

C2 = Array{Float64}(3,5,4)
for i in 1:5, j in 1:4
    C2[:,i,j]= [(i-1)/4,(j-1)/3,rand()]
end

f2 = BSplineSurface(C2, B1,B2, color=Color(100,200,255))

@axlview f1,f2
