export AxlViewer, axlviewer, init

mutable struct AxlViewer
    io::IOStream
end

axlviewer = function(file="tmp.axl")
    io = open(file,"w")
    print(io,"<axl>\n")
    mark(io)
    AxlViewer(io)
end

function init(A::AxlViewer, file="tmp.axl")
    A.io = open(file,"w")
    print(A.io,"<axl>\n")
    mark(A.io)
    flush(A.io)
end

# function view(A::AxlViewer)
#     mark(A.io)
#     print(A.io,"</axl>\n")
#     flush(A.io)
#     wd=pwd()
#     run(`axl tmp.axl`)
# end
