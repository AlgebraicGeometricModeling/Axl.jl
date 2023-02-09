all: Axl.jl
	julia --color=yes make.jl

Axl.jl:
	git clone -b gh-pages https://github.com/AlgebraicGeometricModeling/Axl.jl.git

publish:
	cd Axl.jl; git add docs; git commit -am "update gh-pages"; git push
