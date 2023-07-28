"Abstract type for sources of citable image"
abstract type AbstractImageSource end

"Catch subtypes that fail to implement `rgb_data` function."
function rgb_data(src::T, img::Cite2Urn; extension = "tif", w::Int=2000)::Matrix{RGB{N0f8}} where {T <: AbstractImageSource}
    throw(DomainError("Function `rgb_data` not implemented for type $(T)"))
end

"""Retrieve RGBA data for an image identified by URN from a IIIF service.
Optionally set alpha channel on the resulting image.
$(SIGNATURES)
"""
function rgba_data(src::T, img::Cite2Urn; extension = "tif", w::Int=2000, alpha = 1.0, )::Matrix{RGBA{N0f8}} where {T <: AbstractImageSource}
    RGBA.(rgb_data(src, img; w = w, extension = extension), alpha)
end