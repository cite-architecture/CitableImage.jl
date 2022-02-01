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


# Example CEX:
# urn:cite2:hmt:vaimg.2017a:VA083RN_0084|Venetus A: Marcianus Graecus Z. 454 (= 822).  Photograph in natural light, folio 83, recto.|This image was derived from an original ©2007, Biblioteca Nazionale Marciana, Venezia, Italia. The derivative image is ©2010, Center for Hellenic Studies. Original and derivative are licensed under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 License. The CHS/Marciana Imaging Project was directed by David Jacobs of the British Library.

