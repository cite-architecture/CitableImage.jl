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

"""Number of rows in `imgtable`.
$(SIGNATURES)
"""
function rows(imgtable::T) where (T <: AbstractArray)
    length(imgtable)
end

"""Number of columns in `imgtable`.
$(SIGNATURES)
"""
function columns(imgtable::T) where (T <: AbstractArray)
    if isempty(imgtable) || isempty(imgtable[1])
        0
    else
        length(imgtable[1])
    end
end

"""Compose a markdown table for all pages in `lb`.
$(SIGNATURES)
"""
function mdtables(lb::Lightbox; iiif = CitableImage.DEFAULT_IIIF_SERVICE, ict = CitableImage.DEFAULT_ICT, thumbsize = 100)
    pagemd = []
    for pg in lb.imagepages
        push!(pagemd, mdtable(pg, iiif = iiif, ict = ict, thumbsize = thumbsize))
    end
    pagemd
end

"""Compose a markdown table for page `page` of `lb`
thumbnail image size in pixels == `thumbsize`.
$(SIGNATURES)
"""
function mdtable(lb::Lightbox, page = 1; iiif = CitableImage.DEFAULT_IIIF_SERVICE, ict = CitableImage.DEFAULT_ICT, thumbsize = 100)
    mdtable(lb.imagepages[page], iiif = iiif, ict = ict, thumbsize = thumbsize)
end

"""Compose markdown table header.
$(SIGNATURES)
"""
function mdheaderlines(imgtable)
    labels = "|" * join(["" for _ in 1:columns(imgtable)], "|") * "|"
    spacers = "|" * join(["---" for _ in 1:columns(imgtable)], "|") * "|"
    [labels, spacers]
end

"""Compose a markdown table for `imgtable` with
thumbnail image size in pixels == `thumbsize`.
$(SIGNATURES)
"""
function mdtable(imgtable; iiif = CitableImage.DEFAULT_IIIF_SERVICE, ict = CitableImage.DEFAULT_ICT, thumbsize = 100)
    lines = mdheaderlines(imgtable)

    for r in imgtable
        if ! isnothing(r)
            cells = []
            for c in r
                if isnothing(c)
                    push!(cells, "")
                else
                    md = linkedMarkdownImage(ict, c.urn, iiif; ht=thumbsize, caption=c.caption)
                    push!(cells, md)
                end
            end
            push!(lines, "| " * join(cells, " |") * " |")
        end
    end
    join(lines, "\n")
end

