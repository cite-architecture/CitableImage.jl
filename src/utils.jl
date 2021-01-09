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
Given a region-of-interest string, compute percent values.
"""
function roiFloats(s::AbstractString)
    parts = split(s, ",")
    if (size(parts, 1) != 4)
        throw(ArgumentError("""Invalid region of interest `$(s)`:  expression must have four comma-separated parts."""))
    else 
        floats = map(roi -> parse(Float64, roi) * 100, parts)
        floats
    end
end