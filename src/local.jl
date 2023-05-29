"""An instance of an IIIF image service.

- `basedirectory` is the root directory of image files organized either in a single flat directory, or in a subdirectory tree mirroring image URN components.
- `expandpath` True if paths to images should be expanded to mirror components of an image URN.
"""
struct LocalImageFiles <: AbstractImageSource
    basedirectory::AbstractString
    expandpath::Bool
end


"""Retrieve binary image data cited by `img` from `src`.
$(SIGNATURES)
"""
function imagedata(src::LocalImageFiles, img::Cite2Urn; extension = "jpg", ht::Int=2000) 
    fullimg = imgpath(src, img, extension = extension) |> load  
    if hassubref(img)
        
        floats = []
        for s in split(subref(img), ",") 
            push!(floats, parse(Float64, s))
        end
       roi = TLHWpctRectRoi(floats[1],floats[2], floats[3], floats[4],  size(fullimg, 2), size(fullimg, 1))
        # Slice first:
        sliced = urnslice(fullimg, roi)
        urnscale(sliced, ht)
    else
        urnscale(fullimg, ht)
    end
    
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
    filebase = imgurn |> dropsubref |> objectcomponent 
    filename = filebase * "." * extension
    imgsrc.expandpath ? 
        join([basedirectory(imgsrc), subdirectory(imgurn), filename], "/") : 
        join([basedirectory(imgsrc), filename], "/")
end

"""Base directory for images in a local file system.
$(SIGNATURES)
"""
function basedirectory(imgsrc::LocalImageFiles)
    imgsrc.basedirectory
end