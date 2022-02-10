"A collection of `ImageRecord`s."
struct ImageCollection <: Citable
    description::AbstractString
    images::Vector{ImageRecord}
end

"""Convenience function for creating `ImageCollection`s.
$(SIGNATURES)
"""
function image_collection(images::Vector{ImageRecord}; description = "")
    if isempty(images)
        throw(DomainError("Cannot create an empty `ImageCollection`."))
    end
    label = ""
    if isempty(description)
        if length(images) == 1
            label = "Image collection with 1 image"
        else
            label = "Image collection with $(length(images)) images"
        end
    else
        label = description
    end
    ImageCollection(label, images)
end

"Define singleton type for use with `CitableTrait`"
struct CitableByImage <: CitableTrait end
"""Define value of `CitableTrait` for `ImageCollection`
$(SIGNATURES)
"""
function citabletrait(::Type{ImageCollection})
    CitableByImage()
end

"""Image collections are citable by `Cite2Urn`.
$(SIGNATURES)
"""
function urntype(imgcoll::ImageCollection)
    Cite2Urn
end

"""Find collection-level URN for collection.
$(SIGNATURES)
"""
function urn(imgcoll::ImageCollection)
    dropobject(imgcoll.images[1].urn)
end


"""Find collection-level URN for collection.
$(SIGNATURES)
"""
function label(imgcoll::ImageCollection)
    imgcoll.description
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
"""Define value of `CexTrait` for `ImageCollection`.
$(SIGNATURES)
"""
function cextrait(::Type{ImageCollection})
    ImageCollectionCex()
end
