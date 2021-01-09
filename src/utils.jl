# Utils for turning URNs into paths in file systems
# following CITE architecture conventions


"""
$(SIGNATURES)
Create directory path based on URN structure.
"""
function image_directory(urn::Cite2Urn)
    namespace(urn) * "/" * join(parts(collectioncomponent(urn)), "/")
end



"""
$(SIGNATURES)
Given a region-of-interest string, compute percent values,
with result rounded to a given number of digits.
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

"""
$(SIGNATURES)
Given a region-of-interest string, compose percent expression for IIIF.
"""
function pctString(s::AbstractString)
    floats = join(roiFloats(s), ",")
    "pct:" * floats
end

"""
$(SIGNATURES)
Given a CITE2 URN with region-of-interest subreference, compose percent expression for IIIF.
"""
function pctString(u::Cite2Urn)
    roi = subref(u)
    floats = join(roiFloats(roi), ",")
    "pct:" * floats
end

