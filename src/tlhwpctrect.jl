
"""A rectangular region of interest defined by
top y, left x, height and width of rectangle in percentages.
`x` and `y` are the dimensions in pixels of the image.
$(SIGNATURES)
"""
struct TLHWpctRectRoi <: AbstractRectRoi
    t::Number
    l::Number
    h::Number
    w::Number
    x::Number
    y::Number
end


"""Minimum Y value in pixels for region of interest.
$(SIGNATURES)
"""
function top(r::TLHWpctRectRoi)
    toppix = trunc(Int,r.t * r.y)
    toppix == 0 ? 1 : toppix    
end


"""Minimum X value in pixels for region of interest.
$(SIGNATURES)
"""
function left(r::TLHWpctRectRoi)
    leftpix = trunc(Int,r.l * r.x)
    leftpix == 0 ? 1 : leftpix
end


"""Height in pixels of region of interest.
$(SIGNATURES)
"""
function h(r::TLHWpctRectRoi)
    trunc(Int,r.h * r.y)
end

"""Width in pixels of region of interest.
$(SIGNATURES)
"""
function w(r::TLHWpctRectRoi)
    trunc(Int,r.w * r.x)
end


"""Maximim Y value of region of interest.
$(SIGNATURES)
"""
function bottom(r::TLHWpctRectRoi)
    bottompix = trunc(Int,(r.t + r.h) * r.y)
    bottompix == 0 ? 1 : bottompix
end


"""Maximim X value of region of interest.
$(SIGNATURES)
"""
function right(r::TLHWpctRectRoi)
    rightpix = trunc(Int,(r.l + r.w) * r.x)
    rightpix == 0 ? 1 : rightpix
end