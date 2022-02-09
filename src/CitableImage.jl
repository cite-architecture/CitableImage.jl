module CitableImage
using Documenter, DocStringExtensions

using Images
using FileIO, ImageIO

import Base: show
import Base: ==

using CitableObject
using CitableBase

import CitableBase: citabletrait
import CitableBase: urntype
import CitableBase: urn
import CitableBase: label

import CitableBase: urncomparisontrait
import CitableBase: urnequals
import CitableBase: urncontains
import CitableBase: urnsimilar

import CitableBase: cextrait
import CitableBase: cex
import CitableBase: fromcex

export IIIFservice
export image_directory
export url, markdownImage, linkedMarkdownImage
export htmlImage, linkedHtmlImage
export image_directory

export ImageRecord

include("rois.jl")
include("source.jl")
include("iiif.jl")
include("utils.jl")
include("image.jl")



end # module


