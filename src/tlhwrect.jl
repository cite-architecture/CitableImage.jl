
"""A rectangular region of interest defined by
top y, left x, height and width of rectangle.
$(SIGNATURES)
"""
struct TLHWRectRoi <: AbstractRectRoi
    t::Number
    l::Number
    h::Number
    w::Number
end


function top(r::TLHWRectRoi)
    toppix = trunc(Int, r.t)
    toppix == 0 ? 1 : toppix
end

function left(r::TLHWRectRoi)
    leftpix = trunc(Int, r.l)
    leftpix == 0 ? 1 : leftpix
end

function h(r::TLHWRectRoi)
    trunc(Int,r.h)
end

function w(r::TLHWRectRoi)
    trunc(Int,r.w)
end

function bottom(r::TLHWRectRoi)
    bottompix = trunc(Int,r.t + r.h)
    bottompix == 0 ? 1 : bottompix
end

function right(r::TLHWRectRoi)
    rightpix = trunc(Int,r.l + r.w)
    rightpix == 0 ? 1 : rightpix
end