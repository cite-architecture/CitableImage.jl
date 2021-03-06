# Run this from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
using Pkg
Pkg.activate(".")
Pkg.instantiate()

using Documenter, DocStringExtensions, CitableImage

makedocs(
    sitename = "CitableImage Documentation",
    pages = [
        "Home" => "index.md",
        "Guide" => "guide.md",
        "Server configuration" => "server.md",
        "API documentation" => "apis.md"
    ]
)

deploydocs(
    repo = "github.com/cite-architecture/CitableImage.jl.git",
) 
