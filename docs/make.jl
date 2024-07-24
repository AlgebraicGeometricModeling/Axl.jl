using Documenter, Axl

dir = "mrkd"

docdir = pwd()
Expl = filter(x ->endswith(x,".jl"), readdir("../expl"))

Expls = String[]

for file in Expl
    if file != "runexpl.jl"
        f = replace(file,".jl"=>".md")
        println(" > expl: ", f)
        io = open("mrkd/expl/"*f,"w")
        title = replace(file,".jl" => "")
        title = replace(title,"expl_" => "")
        title = replace(title,"_" => " ")
        println(io,"# ", uppercasefirst(title))
        println(io,"```julia")
        for l in eachline(open("../expl/"*file))
            println(io,l)
        end
        println(io,"```")
        close(io)
        push!(Expls,"expl/"*f)
    end
end

Code = ["viewer.md", "readers.md", "color.md"];

Fcts = map(file -> joinpath("fcts", file), filter(x ->endswith(x, "md"), readdir(dir*"/fcts")))

makedocs(
         sitename = "Axl.jl",
         authors = "B. Mourrain",
         modules = [Axl],
         build = "Axl.jl/docs",
         source = dir,
         pages = Any[
             "Home" => "index.md",
             "Viewer" => "viewer.md",
             "Readers" => "readers.md",
             "Attributes" => "attributes.md",
             "Functions" => Fcts,
             "Examples" => Expls
         ],
         repo = Remotes.GitHub("AlgebraicGeometricModeling", "Axl.jl"),
         doctest = false
         )

