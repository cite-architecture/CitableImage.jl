@testset "Test basic imagerecord structure and citable trait" begin
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)
    img2 = ImageRecord(u, caption, lic)

    @test string(img) == "<urn:cite2:hmt:vaimg.2017a:VA083RN_0084> folio 83 recto, natural light"
    @test img == img2

    @test citable(img)
    @test urntype(typeof(img)) == Cite2Urn
    @test urn(img) == u
    @test label(img) == caption
end


@testset "Test urn comparison trait on basic image record" begin
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    coll = dropobject(u)
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)

    @test urncomparable(img)
    @test urnequals(coll, img) == false
    @test urncontains(coll, img) 
    @test urnsimilar(coll, img) 
end



@testset "Test Cex trait on basic image record" begin
    # cex, fromcex
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)

    @test cexserializable(img)
    expected = "urn:cite2:hmt:vaimg.2017a:VA083RN_0084|folio 83 recto, natural light|CC-by-share"
    @test cex(img) == expected
    @test fromcex(cex(img), ImageRecord) == img
end