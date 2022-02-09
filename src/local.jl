"""An instance of an IIIF image service.

- `basedirectory` is the root directory of image files organized either in a single flat directory, or in a subdirectory tree mirroring image URN components.
- `expandpath` True if paths to images should be expanded to mirror components of an image URN.
"""
struct LocalImageFiles <: AbstractImageSource
    basedirectory::AbstractString
    expandpath::Bool
end



function imagedata(src::LocalImageFiles, img::Cite2Urn; extension = "jpg", ht::Int=2000) 
    imgpath(src, img, extension = extension) |> load
end


"""Convenience function to create a `LocalImageFiles` that will expand paths from URNs by default.
$(SIGNATURES)
"""
function localimages(basedir::AbstractString; expandpath = true)
    LocalImageFiles(basedir, expandpath)
end


"""Compose full path to the image file `imgurn`.
$(SIGNATURES)
"""
function imgpath(imgsrc::LocalImageFiles, imgurn::Cite2Urn; extension = "jpg")
    filebase = imgurn |> CitableObject.dropsubref |> objectcomponent 
    filename = filebase * "." * extension
    imgsrc.expandpath ? 
        joinpath(basedirectory(imgsrc), subdirectory(imgurn), filename) : 
        joinpath(basedirectory(imgsrc), filename)
end

"""Base directory for images in a local file system.
$(SIGNATURES)
"""
function basedirectory(imgsrc::LocalImageFiles)
    imgsrc.basedirectory
end