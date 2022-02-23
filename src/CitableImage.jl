module CitableImage
using Documenter, DocStringExtensions

using Images
using FileIO, ImageIO
using Downloads

import Base: show
import Base: ==

using Base.Iterators
import Base: length
import Base: eltype
import Base: iterate
import Base: filter
import Base: reverse


using CitableBase
using CiteEXchange
using CitableObject
using CitableObject.CexUtils

import CitableBase: citablecollectiontrait

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


export AbstractImageSource
export imagedata

export AbstractRectRoi
export top, left, bottom, right, h, w
export TLHWRectRoi, TLHWpctRectRoi

export IIIFservice
export subdirectory
export url, markdownImage, linkedMarkdownImage
export htmlImage, linkedHtmlImage
export subdirectory

export LocalImageFiles, localimages

export ImageRecord
export ImageCollection, image_collection

export Lightbox, lightbox
export pages, rows, columns, page, mdtable


include("rois.jl")
include("tlhwrect.jl")
include("tlhwpctrect.jl")

include("imageutils.jl")
include("iiifutils.jl")
include("source.jl")
include("iiif.jl")
include("local.jl")

include("image.jl")
include("constants.jl")
include("collection.jl")
include("lightbox.jl")




end # module


