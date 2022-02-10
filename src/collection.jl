"A collection of `ImageRecord`s."
struct ImageCollection
    images::Vector{ImageRecord}
end

"""Override `Base.==` for `ImageCollection`.
$(SIGNATURES)
"""
function ==(c1::ImageCollection, c2::ImageCollection)
    c1.images == c2.images
end


"""Override `Base.show` for `ImageCollection`.
$(SIGNATURES)
"""
function show(io::IO, imgcoll::ImageCollection)
    imgcount = length(imgcoll.images)
    if imgcount == 1 
        print(io, "Citable collection with 1 image")
    else
        print(io, "Citable collection with ", imgcount, " image")
    end
end


"""Define singleton type to use as value for `CitableCollectionTrait`."""
struct CitableImageCollection <: CitableCollectionTrait end
"""Define value of `CitableCollectionTrait` for `ImageCollection`.
$(SIGNATURES)
"""
function citablecollectiontrait(::Type{ImageCollection})
    CitableImageCollection()
end


"""Define singleton type to use as value for `UrnComparisonTrait`."""
struct ImageCollectionComparable <: UrnComparisonTrait end
"""Define value of `UrnComparisonTrait` for `ImageCollection`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{ImageCollection})
    ImageCollectionComparable()
end


"""Implement URN comparison for equality on `imgcoll`.
$(SIGNATURES)
"""
function urnequals(u::Cite2Urn, imgcoll::ImageCollection )
    filter(img -> urnequals(u, img.urn), imgcoll.images)
end


"""Implement URN comparison for containment on `imgcoll`.
$(SIGNATURES)
"""
function urncontains(u::Cite2Urn, imgcoll::ImageCollection )
    filter(img -> urncontains(u, img.urn), imgcoll.images)
end

"""Implement URN comparison for similarity on `imgcoll`.
$(SIGNATURES)
"""
function urnsimilar(u::Cite2Urn, imgcoll::ImageCollection )
    filter(img -> urnsimilar(u, img.urn), imgcoll.images)
end


"""Define singleton type to use as value for `CitableCollectionTrait`."""
struct ImageCollectionCex <: CexTrait end
"""Define value of `CexTrait` for `Codex`.
$(SIGNATURES)
"""
function cextrait(::Type{ImageCollection})
    ImageCollectionCex()
end
