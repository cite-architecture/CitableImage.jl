# Utils for turning URNs into paths in file systems
# following CITE architecture conventions

function image_directory(urn::Cite2Urn)
    namespace(urn) * "/" * join(parts(collectioncomponent(urn)), "/")
end