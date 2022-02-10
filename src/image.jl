"Metadata for a citable digital image"
struct ImageRecord <: Citable
    urn::Cite2Urn
    caption::AbstractString
    license::AbstractString
end


"""Override `show` for `ImageRecord`
$(SIGNATURES)
Required for `CitableTrait`.
"""
function show(io::IO, img::ImageRecord)
    print(io, "<", img.urn, "> ", img.caption)
end

"""Override `==` for `ImageRecord`
$(SIGNATURES)
"""
function ==(img1::ImageRecord, img2::ImageRecord)
    img1.urn.urn == img2.urn.urn && img1.caption == img2.caption && img1.license == img2.license
end



"Define singleton type to use as value of `CitableTrait` on `ImageRecord`."
struct ImageCitable <: CitableTrait end
"""Set value of `CitableTrait` for `ImageRecord`.
$(SIGNATURES)
"""
function citabletrait(::Type{ImageRecord})
    ImageCitable()
end

"""Type of URN identifying an `ImageRecord`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urntype(::Type{ImageRecord})
    Cite2Urn
end


"""URN identifying `img`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function urn(img::ImageRecord)
    img.urn
end

"""Label for `img`.
$(SIGNATURES)
Required function for `Citable` abstraction.
"""
function label(img::ImageRecord)
    img.caption
end




"Define singleton type to use as value of `UrnComparisonTrait` on `MSPage`."
struct ImageComparable <: UrnComparisonTrait end
"""Set value of `UrnComparisonTrait` for `ImageRecord`.
$(SIGNATURES)
"""
function urncomparisontrait(::Type{ImageRecord})
    ImageComparable()
end

"""Implement urn comparison for equality for `ImageRecord`.
$(SIGNATURES)
"""
function urnequals(u::Cite2Urn, img::ImageRecord)
    img.urn == u
end

"""Implement urn comparison for containment for `ImageRecord`.
$(SIGNATURES)
"""
function urncontains(u::Cite2Urn, img::ImageRecord)
    urncontains(u, img.urn)
end
"""Implement urn comparison for similarity for `ImageRecord`.
$(SIGNATURES)
"""
function urnsimilar(u::Cite2Urn, img::ImageRecord)
    urnsimilar(u, img.urn)
end


# Example CEX:
# urn:cite2:hmt:vaimg.2017a:VA083RN_0084|Venetus A: Marcianus Graecus Z. 454 (= 822).  Photograph in natural light, folio 83, recto.|This image was derived from an original ©2007, Biblioteca Nazionale Marciana, Venezia, Italia. The derivative image is ©2010, Center for Hellenic Studies. Original and derivative are licensed under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. The CHS/Marciana Imaging Project was directed by David Jacobs of the British Library.


"Define singleton type to use as value of `CexTrait` on `MSPage`."
struct ImageCex <: CexTrait end
import CitableBase: cextrait
"""Set value of `CexTrait` for `MSPage`.
$(SIGNATURES)
"""
function cextrait(::Type{ImageRecord})
    ImageCex()
end

"""Serialize `img` to delimited text.
$(SIGNATURES)
Required for `CexTrait`.
"""    
function cex(img::ImageRecord; delimiter = "|")
    join([string(img.urn), img.caption, img.license], delimiter)
end


"""Instantiate a `MSPage`from delimited text.
$(SIGNATURES)
"""
function fromcex(traitvalue::ImageCex, cexsrc::AbstractString, T;
    delimiter = "|", configuration = nothing, strict = true)
    fields = split(cexsrc, delimiter)
    urn = Cite2Urn(fields[1])
    caption = fields[2]
    license = fields[3]
    ImageRecord(urn, caption, license)
end

