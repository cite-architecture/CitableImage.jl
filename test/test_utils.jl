@testset "Test file path utilities" begin
    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.15,0.10,0.10,0.1")
    CitableImage.subdirectory(imgurn) == "hmt/vaimg/2017a"
end
