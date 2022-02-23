
IMAGE_MODEL = Cite2Urn("urn:cite2:cite:datamodels.v1:imagemodel")

# This is insane, but this is literally what happens if you create a `Ligthbox` 
# using `partitionvect`.
LIGHTBOX_TYPE = SubArray{Union{Nothing, SubArray{ImageRecord, 1, Vector{ImageRecord}, Tuple{UnitRange{Int64}}, true}}, 1, Vector{Union{Nothing, SubArray{ImageRecord, 1, Vector{ImageRecord}, Tuple{UnitRange{Int64}}, true}}}, Tuple{UnitRange{Int64}}, true}