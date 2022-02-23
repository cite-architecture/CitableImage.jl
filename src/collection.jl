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



"""Serialize `imgcoll` to delimited text in CEX format.
$(SIGNATURES)

"""
function cex(imgcoll::ImageCollection; delimiter = "|")
    datalines = ["#!citedata",
    join(["urn","caption","rights"], delimiter)    
    ]
    for img in imgcoll.images
        push!(datalines, cex(img, delimiter = delimiter))
    end
   

    datamodelcex(imgcoll, delimiter = delimiter)  * "\n\n" * propertiescex(imgcoll, delimiter = delimiter) * "\n\n" * join(datalines, "\n")
end


"""Compose `datamodels` CEX block for `imgcoll`.
$(SIGNATURES)
"""
function datamodelcex(imgcoll::ImageCollection; delimiter = "|")
    lines = [
        "#!datamodels",
        "Collection|Model|Label|Description",
        join([string(urn(imgcoll)), string(IMAGE_MODEL), label(imgcoll)], delimiter)      
    ]
    join(lines, "\n")
end


"""Compose `citeproperties` CEX blocks for `imgcoll`.
$(SIGNATURES)
"""
function propertiescex(imgcoll::ImageCollection; delimiter = "|")
    urnsettings = join([
        string(addproperty(urn(imgcoll), "urn")),
        "URN",
        "Cite2Urn",
        ""
    ], delimiter)

    labelsettings = join([
        string(addproperty(urn(imgcoll), "label")),
        "Label",
        "String",
        ""
    ], delimiter)

    rightssettings = join([
        string(addproperty(urn(imgcoll), "rights")),
        "Rights",
        "String",
        ""
    ], delimiter)

    lines = ["#!citeproperties",
        "Property|Label|Type|Authority list",
        urnsettings,
        labelsettings,
        rightssettings
    ]  
    join(lines, "\n")
end


"""Instantiate an `ImageCollection` from `cexsrc`.
$(SIGNATURES)
If `strict` is true, then the function uses data model declarations
to find relevant data lines.  If `strict` is false, then it assumes
that no more than on `citedata` block is present in the CEX.
"""
function fromcex(trait::ImageCollectionCex, cexsrc::AbstractString, T;
    delimiter = "|", configuration = nothing, strict = true)

    datalines = strict ? data_for_model(cexsrc, CitableImage.IMAGE_MODEL) : CiteEXchange.data(cexsrc, "citedata")

    imglist  = ImageRecord[]
    for ln in datalines
        push!(imglist, fromcex(ln, ImageRecord, delimiter = delimiter))
    end
    image_collection(imglist)
end


"""Number of images in collection.
$(SIGNATURES)
"""
function length(imgcoll::ImageCollection)
    length(imgcoll.images)
end
	
"""An `ImageCollection` is a collection of `ImageRecord`s.
$(SIGNATURES)
"""
function eltype(imgcoll::ImageCollection)
    ImageRecord
end

"""Initial state of iterator for an `ImageCollection`.
$(SIGNATURES)
"""
function iterate(imgcoll::ImageCollection)
    isempty(imgcoll.images) ? nothing : (imgcoll.images[1], 2)
end

"""Iterate an `ImageCollection` with array index at `state`.
$(SIGNATURES)
"""
function iterate(imgcoll::ImageCollection, state)
    state > length(imgcoll.images) ? nothing : (imgcoll.images[state], state + 1)
end

"""Filter the list of images in an `ImageCollection`.
$(SIGNATURES)
"""
function filter(f, imgcoll::ImageCollection)
     Iterators.filter(f, collect(imgcoll))
end

"""Reverse the order of images in an `ImageCollection`.
$(SIGNATURES)
"""
function reverse(imgcoll::ImageCollection)
    reverse(imgcoll.images)
end

