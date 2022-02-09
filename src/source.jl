"Abstract type for sources of citable image"
abstract type AbstractImageSource end

"Catch subtypes that fail to implement `imagedata` function."
function imagedata(src::T, img::Cite2Urn)
    throw(DomainError("Function `imagedata` not implemented for type $(T)"))
end

