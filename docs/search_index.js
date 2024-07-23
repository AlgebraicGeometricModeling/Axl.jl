var documenterSearchIndex = {"docs":
[{"location":"readers/#Readers","page":"Readers","title":"Readers","text":"","category":"section"},{"location":"readers/#Axl-reader","page":"Readers","title":"Axl reader","text":"","category":"section"},{"location":"readers/","page":"Readers","title":"Readers","text":"It is possible to read Axl files and get the list of geometric objects contains in these files, using the function axlread.","category":"page"},{"location":"readers/","page":"Readers","title":"Readers","text":"axlread","category":"page"},{"location":"readers/#Axl.axlread","page":"Readers","title":"Axl.axlread","text":"Read an axl file and ouput the list of objets:\n\naxlread(\"file.axl\")\n\nThe function uses the table Axl.Reader::Dict{String,Function} to determine how to read  the elements in the file. The functions needed to read an object of a given type \"key\" are defined as follows:\n\nReader[\"key\"] = function(obj::EzXML.Node) ... end\n\nIf the element obj has a key type then the reader Reader[obj[\"type\"]] is used, otherwise the reader Reader[nodename(obj)] is used.\n\n\n\n\n\n","category":"function"},{"location":"readers/","page":"Readers","title":"Readers","text":"Here is an example of objects saved in the file tmp.axl with the command @axlview and read with the function axlread. ","category":"page"},{"location":"readers/","page":"Readers","title":"Readers","text":"s = sphere(point(0.,1.,0.), 0.5, color=Color(255,0,0))\nc = cube(point(0.,0.,0.), 0.5, field=[Float64(i) for i in 1:8])\n@axlview s,c\nl = axlread(\"tmp.axl\")","category":"page"},{"location":"readers/","page":"Readers","title":"Readers","text":"The list l contains a copy of the sphere s and of the mesh c.","category":"page"},{"location":"readers/#Obj-reader","page":"Readers","title":"Obj reader","text":"","category":"section"},{"location":"readers/","page":"Readers","title":"Readers","text":"objread","category":"page"},{"location":"readers/#Axl.objread","page":"Readers","title":"Axl.objread","text":"Read an obj file and ouput a mesh.\n\nobjread(\"file.obj\")\n\n\n\n\n\n","category":"function"},{"location":"expl/parametrisations/#Parametrisations","page":"Parametrisations","title":"Parametrisations","text":"","category":"section"},{"location":"expl/parametrisations/","page":"Parametrisations","title":"Parametrisations","text":"using Axl\n@axlview polar((x,y,z)->cos(x*y*z+1.0), 200, field=DistField())","category":"page"},{"location":"fcts/dots/#Point-plots","page":"Point plots","title":"Point plots","text":"","category":"section"},{"location":"fcts/dots/","page":"Point plots","title":"Point plots","text":"dots","category":"page"},{"location":"fcts/dots/#Axl.dots","page":"Point plots","title":"Axl.dots","text":"Output the array of complex values as a mesh of points in the plane.\n\ndots(rand(Complex{Float64},100),color=color(0,100,155),size=0.7)\n\n\n\n\n\nOutput the matrix entries as a mesh of points in the plane with the color map according to their absolute values. If the absolute value of the entrie is smaller than eps (default value 1.e-6), it is not plot. The entrie M[i,j] is put in position ((j-1)/(min(n1,n2)-1), (n1-i)/(min(n1,n2)-1)).\n\ndots(rand(25,100))\ndots(rand(25,100),0.2)\n\n\n\n\n\n","category":"function"},{"location":"fcts/dots/","page":"Point plots","title":"Point plots","text":"(Image: randmatrix)","category":"page"},{"location":"fcts/dots/","page":"Point plots","title":"Point plots","text":"dotsupport","category":"page"},{"location":"fcts/dots/#Axl.dotsupport","page":"Point plots","title":"Axl.dotsupport","text":"Output the support of polynomial as a mesh of points. Only the exponents of the first 3 variables in the monomials are used. If the polynomial is with n variables, the mesh is in dimension min(n,3).\n\np = x^2 + y^2-1\ndotsupport(p)\n\n\n\n\n\n","category":"function"},{"location":"attributes/#Attributes","page":"Attributes","title":"Attributes","text":"","category":"section"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"The attributes of a geometric object are","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"color::Color: a color given by its rgb components\nsize::Color: a number (::Float64) indicatingthe size of points or of a curve \nfield: a function, a type or an array describing a field on the object. ","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"They are attributed by providing key=value parameters in the construction of the object or by assignement","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"obj[:key]=value","category":"page"},{"location":"attributes/#Color","page":"Attributes","title":"Color","text":"","category":"section"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"Here is an example of a sphere, with the attribute color set to the red color.","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"S = sphere(point(0.,1.,0.), 0.5, color=Color(255,0,0))","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"(Image: Color)","category":"page"},{"location":"attributes/#Fields","page":"Attributes","title":"Fields","text":"","category":"section"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"Here is an example of a cylinder, with a directional field for the direction [1,1,0].","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"C = cylinder(point(0.,0.,0.), point(0.,1.,0.), 0.5, field=DirField(1.,1.,0.))","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"(Image: DirField)","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"here is an example with a distance field:","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"C = cone(point(0.,0.,0.), point(0.,1.,0.), 0.5, field=DistField(0.5,0.,0.))","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"(Image: DistField)","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"A field can also be described by an array of values, attached for instance to the vertices of a mesh.    ","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"C = cube(point(0.,0.,0.), 0.5, field=[Float64(i) for i in 1:8])","category":"page"},{"location":"attributes/","page":"Attributes","title":"Attributes","text":"(Image: DistField)","category":"page"},{"location":"viewer/#Viewer","page":"Viewer","title":"Viewer","text":"","category":"section"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"The objects in SemiAlgebraicTypes can be vizualized, using Axl. They are printed in a file tmp.axl and Axl is then run on this view file.","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"@axl start","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"Initialize the view file.","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"@axl m","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"Add the object m to the viewfile.","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"@axl view","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"Open Axl for visualization of the data in the view file. ","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"@axlview","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"This is equivalent to @axl view.","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"@axlview m","category":"page"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"Save the object m in the viewfile and visualize it","category":"page"},{"location":"viewer/#Example","page":"Viewer","title":"Example","text":"","category":"section"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"using Axl\n@axl start\nA = point(0.,0.5,0.)\nB = point(0.,1.5,0.)\nC = point(0.,3.5,0.)\n\n@axl c0 = cylinder(A,B,0.2, color=Color(255,0,0))\n@axl c1 = cone(C,B,0.7, color=Color(0,255,0))\n@axl view\n\n@axlview c0, sphere(A,0.5)","category":"page"},{"location":"viewer/#Functions","page":"Viewer","title":"Functions","text":"","category":"section"},{"location":"viewer/","page":"Viewer","title":"Viewer","text":"@axl\n@axlview\nobjprint","category":"page"},{"location":"viewer/#Axl.@axl","page":"Viewer","title":"Axl.@axl","text":"Initiliaze an Axl view, or add objects to the view or visualize using Axl viewer.\n\n@axl start\n@axl O = point(0.,0.,0.)\nA = point(1.,0.,0.); S = sphere(A, 0.5, color=Color(255,0,0)); @axl A,S\n@axl view\n\n\n\n\n\n","category":"macro"},{"location":"viewer/#Axl.@axlview","page":"Viewer","title":"Axl.@axlview","text":"Display a geometric object with Axl. If no argument is given, the last view is used if it exists.\n\n@axlview A = point(1.,1.,1.)\nA=point(1.,1.,0.); S=sphere(point(0.,0.,0.),0.5, color=color(255,0,0)); @axlview A,S\n@axlview\n\n\n\n\n\n","category":"macro"},{"location":"viewer/#Axl.objprint","page":"Viewer","title":"Axl.objprint","text":"Print a mesh in an obj file.\n\nobjprint(m, \"file.obj\")\n\n\n\n\n\n","category":"function"},{"location":"expl/dots/#Dots","page":"Dots","title":"Dots","text":"","category":"section"},{"location":"expl/dots/","page":"Dots","title":"Dots","text":"using Axl\n@axlview dots(rand(25,100))","category":"page"},{"location":"expl/basic_objects/#Basic-objects","page":"Basic objects","title":"Basic objects","text":"","category":"section"},{"location":"expl/basic_objects/","page":"Basic objects","title":"Basic objects","text":"using SemiAlgebraicTypes\nusing Axl\n\n\n@axl start\n@axl A = point(0.,0.5,0.)\n@axl B = point(0.,1.5,0.)\nC = point(0.,3.5,0.)\n\nc0 = cylinder(A,B,0.2, color=Color(255,0,0))\nc1 = cone(C,B,0.7, color=Color(0,255,0))\n\n@axl c0, c1\n@axl m  = mesh([[cos(i*pi/5), sin(i*pi/5), 0.0] for i in 1:10], Edge[], [[1,i,i+1] for i in 1:9], field = DirField(2.,0.,0.))\n\n@axl view\n        ","category":"page"},{"location":"expl/bspline_curves_and_surfaces/#Bspline-curves-and-surfaces","page":"Bspline curves and surfaces","title":"Bspline curves and surfaces","text":"","category":"section"},{"location":"expl/bspline_curves_and_surfaces/","page":"Bspline curves and surfaces","title":"Bspline curves and surfaces","text":"using Axl\n\nB1 = BSplineBasis(LinRange(0., 2., 4), 3)\nB2 = BSplineBasis(LinRange(0., 1., 3), 3)\n\nC1 = [rand()*j^2/10. for i in 1:3, j in 1:5]\nf1 = BSplineCurve(C1, B1, color=Color(255,0,0))\n\nC2 = [rand()*j*k^2/20 for i in 1:3, j in 1:5, k in 1:4]\nf2 = BSplineSurface(C2, B1,B2, color=Color(100,200,255))\n\n@axlview f1,f2","category":"page"},{"location":"#Axl.jl","page":"Home","title":"Axl.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The package allows to vizualise geometric objects with Axl. It depends on the package SemiAlgebraictypes.jl, which provides the geometric objects.","category":"page"},{"location":"#Geometric-objects","page":"Home","title":"Geometric objects","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"The package handles the following types:","category":"page"},{"location":"","page":"Home","title":"Home","text":"point, line, sphere, cylinder, cone, ellipsoid, torus\nmesh with normals, fields\nbspline curve, surface, volume","category":"page"},{"location":"#Installation","page":"Home","title":"Installation","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"To use this package, julia needs first to be installed (see here).","category":"page"},{"location":"","page":"Home","title":"Home","text":"The package can then be installed from Julia as follows:","category":"page"},{"location":"","page":"Home","title":"Home","text":"] add https://github.com/AlgebraicGeometricModeling/Axl.jl\nbuild Axl","category":"page"},{"location":"","page":"Home","title":"Home","text":"This installation checks that axl is installed. If not, a warning message with instructions to install it is printed.  See here more details on how to install axl.","category":"page"},{"location":"#Using-Axl.jl","page":"Home","title":"Using Axl.jl","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Here is an example with a cylinder, a cone and a mesh:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Axl\n\n@axl start\n@axl A = point(0.,0.5,0.)\n@axl B = point(0.,1.5,0.)\nC = point(0.,3.5,0.)\n\nc0 = cylinder(A,B,0.2, color=Color(255,0,0))\nc1 = cone(C,B,0.7, color=Color(0,255,0))\n\n@axl c0, c1\n@axl m = mesh([[cos(i*pi/5), sin(i*pi/5), 0.0] for i in 1:10], Edge[], [[1,i,i+1] for i in 1:9], field = DirField(1.,0.,0.))\n\n@axl view","category":"page"},{"location":"","page":"Home","title":"Home","text":"Here is an example of the visualization of a bspline surface:","category":"page"},{"location":"","page":"Home","title":"Home","text":"using Axl\n\nB1 = BSplineBasis(LinRange(0., 2., 4), 3)\nB2 = BSplineBasis(LinRange(0., 1., 3), 3)\n\nC = fill(0.0,3,5,4)\nfor i in 1:5, j in 1:4\n    C[:,i,j] = [i-1,j-1,5*rand()-2.5]\nend\ns = BSplineSurface(C, B1,B2, color=Color(150,200,255))\n\n@axlview s\n","category":"page"},{"location":"#More-information","page":"Home","title":"More information","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation\nGithub","category":"page"},{"location":"fcts/parametric/#Parametric-plots","page":"Parametric plots","title":"Parametric plots","text":"","category":"section"},{"location":"fcts/parametric/","page":"Parametric plots","title":"Parametric plots","text":"parametric","category":"page"},{"location":"fcts/parametric/#Axl.parametric","page":"Parametric plots","title":"Axl.parametric","text":"Compute the parametric curve f: u -> [x,y,z] for u in the interval X.\n\nc = parametric(u->[u,sin(u^2),cos(2*u)], 0.0 => 2.0*pi, 1000; field=DistField(0.0,0.0,0.0))\n@axlview c\n\n\n\n\n\nCompute the parametric surface f: (u,v) -> [x,y,z] for u in the interval X, v in the interval Y.\n\ns = parametric((u,v)->[u,v,cos(2*u*v)], 0.0 => 2.0, -pi => pi, field=DistField(0.0,0.0,0.0))\n@axlview s\n\n\n\n\n\n","category":"function"},{"location":"fcts/parametric/","page":"Parametric plots","title":"Parametric plots","text":"(Image: parametric)","category":"page"},{"location":"fcts/parametric/","page":"Parametric plots","title":"Parametric plots","text":"polar","category":"page"},{"location":"fcts/parametric/#Axl.polar","page":"Parametric plots","title":"Axl.polar","text":"Plot the radius function r = f(x,y,z) on the unitary sphere.\n\npolar((x,y,z)->cos(x*y*z+1.0), 200, field=DistField())\n\n\n\n\n\n","category":"function"},{"location":"fcts/parametric/","page":"Parametric plots","title":"Parametric plots","text":"(Image: polar)","category":"page"}]
}