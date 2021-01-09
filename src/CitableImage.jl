module CitableImage

using CitableObject
using CitableBase
using Documenter, DocStringExtensions

export IIIFservice
export image_directory
export url, markdownImage, linkedMarkdownImage
# Future release
#export htmlImage, linkedHtmlImage
    


include("iiif.jl")
include("utils.jl")



end # module


