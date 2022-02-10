# Utils for turning URNs into paths in file systems
# following CITE architecture conventions

"""Create directory path for a given urn.

$(SIGNATURES)
"""
function subdirectory(urn::Cite2Urn)
    collpath = joinpath(parts(collectioncomponent(urn))...)
    joinpath(namespace(urn), collpath)
end

"""Extract a slice from `img` defined by a list of
four values giving left top, width and height of a
rectangle to extract.
$(SIGNATURES)
"""
function urnslice(img, rect::T) where {T <: AbstractRectRoi}
    #(x, y, w, h) = floatvals

    xpix = trunc(Int, left(rect)) #trunc(Int, x * 512)
    x2pix = trunc(Int, left(rect) + w(rect)) #xpix + w * 512)
    ypix = trunc(Int, top(rect)) #y * 768)
    y2pix = trunc(Int, top(rect) + h(rect))#ypix + h * 768)

    if xpix == 0
        xpix = 1
    end
    if ypix == 0
        ypix = 1
    end
    img[ypix:y2pix, xpix:x2pix]
end

"""Scale an image to a fixed height.
$(SIGNATURES)
"""
function urnscale(img, ht = 300)
    percentage_scale = ht / size(img,1)
    new_size = trunc.(Int, size(img) .* percentage_scale)
    imresize(img, new_size)
end



"""Given a region-of-interest string, compute percent values,
with result rounded to a given number of digits.

$(SIGNATURES)

# Arguments

- `s` string with four comma-separated ROI values
- `digits` precision of resulting float
"""
function roiFloats(s::AbstractString, digits::Int = 3)
    parts = split(s, ",")
    if (size(parts, 1) != 4)
        throw(ArgumentError("""Invalid region of interest `$(s)`:  expression must have four comma-separated parts."""))
    else 
        floats = map(roi -> parse(Float64, roi) * 100, parts)
        map(num -> round(num, digits=digits), floats)
    end
end

"""Given a region-of-interest string, compose percent expression for IIIF.

$(SIGNATURES)

# Argument
- `s`  string with four comma-separated ROI values
"""
function pctString(s::AbstractString)
    floats = join(roiFloats(s), ",")
    "pct:" * floats
end

""" Given a CITE2 URN with region-of-interest subreference, compose percent expression for IIIF.
$(SIGNATURES)

"""
function pctString(u::Cite2Urn)
    roi = subref(u)
    floats = join(roiFloats(roi), ",")
    "pct:" * floats
end