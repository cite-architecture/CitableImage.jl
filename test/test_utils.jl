@testset "Test URN manipulation utilities" begin
    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.15,0.10,0.10,0.1")
    @test CitableImage.subdirectory(imgurn) == "hmt/vaimg/2017a"

    @test imagefloats(imgurn) == (left = 0.15, top = 0.1, width = 0.1, height = 0.1)
    @test imagefloats(imgurn, digits = 1) == (left = 0.2, top = 0.1, width = 0.1, height = 0.1)

end
