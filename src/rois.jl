"Basic abstraction for region-of-interest"
abstract type AbstractRoi end

"Rectangular regions of interest"
abstract type AbstractRectRoi <: AbstractRoi end


"Catch subtypes of `AbstractRectRoi`  that fail to implement `top`"
function top(rect::T) where {T <: AbstractRectRoi}
    throw(DomainError("Function `top` not implemented for type $(T)"))
end



"Catch subtypes of `AbstractRectRoi`  that fail to implement `left`"
function left(rect::T) where {T <: AbstractRectRoi}
    throw(DomainError("Function `left` not implemented for type $(T)"))
end


"Catch subtypes of `AbstractRectRoi`  that fail to implement `bottom`"
function bottom(rect::T) where {T <: AbstractRectRoi}
    throw(DomainError("Function `bottom` not implemented for type $(T)"))
end

"Catch subtypes of `AbstractRectRoi`  that fail to implement `right`"
function right(rect::T) where {T <: AbstractRectRoi}
    throw(DomainError("Function `right` not implemented for type $(T)"))
end



"Catch subtypes of `AbstractRectRoi`  that fail to implement `w`"
function w(rect::T) where {T <: AbstractRectRoi}
    throw(DomainError("Function `w` not implemented for type $(T)"))
end





"Catch subtypes of `AbstractRectRoi` that fail to implement `h`"
function h(rect::T) where {T <: AbstractRectRoi}
    throw(DomainError("Function `h` not implemented for type $(T)"))
end