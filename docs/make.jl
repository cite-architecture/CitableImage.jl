using Pkg
pkg"activate .."
push!(LOAD_PATH,"../src/")


using Documenter, DocStringExtensions, CitableImage

makedocs(sitename = "CitableImage Documentation")
