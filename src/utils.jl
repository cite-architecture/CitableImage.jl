# Utils for turning URNs into paths in file systems
# following CITE architecture conventions


"""
$(SIGNATURES)

"""
function image_directory(urn::Cite2Urn)
    namespace(urn) * "/" * join(parts(collectioncomponent(urn)), "/")
end



function roiFloats(s::AbstractString)