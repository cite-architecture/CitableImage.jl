module CitableImage

using CitableObject
using CitableBase

export IIIFservice
export image_directory
export url, markdownImage, htmlImage, 
    linkedMarkdownImage, linkedHtmlImage


include("iiif.jl")
include("pathutils.jl")

end # module


