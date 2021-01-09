
@testset "Derive path from URN" begin
urn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.12345,0.22345,0.32345,0.42345")
expected = "hmt/vaimg/2017a"
@test image_directory(urn) == expected
end