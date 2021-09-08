# Build docs from repository root, e.g. with
# 
#    julia --project=docs/ docs/make.jl
#
# Serve docs this repository root to serve:
#
#   julia -e 'using LiveServer; serve(dir="docs/build")'julia -e 'using LiveServer; serve(dir="docs/build")' 
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
