@testset "Test basic imagerecord structure" begin
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)
    img2 = ImageRecord(u, caption, lic)

    @test string(img) == "<urn:cite2:hmt:vaimg.2017a:VA083RN_0084> folio 83 recto, natural light"
    @test img == img2
end