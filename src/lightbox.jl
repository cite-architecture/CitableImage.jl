"""Structure to hold images in a 2-D array of rowsXcolumns."""
struct Lightbox
    imagepages
end

"""Begin iterating pages of a `Lightbox` with page 1.
$(SIGNATURES)
"""
function iterate(lb::Lightbox)
    isempty(lb.imagepages) ? nothing : (lb.imagepages[1], 2)
end

"""Iterate pages of a `Lightbox` from page  given in `state`.
$(SIGNATURES)
"""
function iterate(lb::Lightbox, state)
    state > length(lb.imagepages) ? nothing : (lb.imagepages[state], state + 1)
end

"""Construct a `Lightbox` from an `ImageCollection`.
$(SIGNATURES)
"""
function lightbox(imgcoll::ImageCollection; cols = 6, rows = 25)
    lbvect = partitionvect(partitionvect(imgcoll.images, n = cols), n = rows)
    Lightbox(lbvect)
end

"""Retrieve page `n` from `lb`.
$(SIGNATURES)
"""
function page(lb::Lightbox; n = 1)
    lb.imagepages[n]
end

"""Number of paged RxC tables in `lb`.
$(SIGNATURES)
"""
function pages(lb::Lightbox)
    length(lb.imagepages)
end

"""Number of rows per page in `lb`.
$(SIGNATURES)
"""
function rows(lb::Lightbox)
    isempty(lb.imagepages) ? 0 : length(lb.imagepages[1])
end

"""Number of columns per page in `lb`.
$(SIGNATURES)
"""
function columns(lb::Lightbox)
    if isempty(lb.imagepages)
        0
    elseif isempty(lb.imagepages[1])
        0
    else
        lb.imagepages[1][1] |> length
    end
end

"""Compose a markdown table for page `page` of `lb`
thumbnail image size in pixels == `thumbsize`.
$(SIGNATURES)
"""
function mdtable(lb::Lightbox; page = 1, thumbsize = 100)
    # ITERATE IT AND THUMB THEM
end


