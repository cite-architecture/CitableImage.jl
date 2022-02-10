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


