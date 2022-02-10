@testset "Test basic structure and citable trait of `ImageCollection`" begin
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)

    imgcoll = image_collection([img])
    @test imgcoll isa ImageCollection
    @test string(imgcoll) == "Citable collection with 1 image"

    img2 = ImageRecord(u, caption, lic)
    coll2 = image_collection([img2])
    @test imgcoll == coll2

    @test citablecollection(imgcoll)

    @test citable(imgcoll)
    @test urntype(imgcoll) == Cite2Urn
    @test urn(imgcoll) == Cite2Urn("urn:cite2:hmt:vaimg.2017a:")
    @test label(imgcoll) == "Image collection with 1 image"

end

@testset "Test urn comparison trait of `ImageCollection`" begin
    # urncomparable, urnequals, urncontains, urnsimilar
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)

    imgcoll = image_collection([img])
    @test urncomparable(imgcoll)

    collurn = dropobject(u)
    @test urnequals(collurn, imgcoll) |> isempty
    @test urncontains(collurn, imgcoll) |> length == 1
    @test urnsimilar(collurn, imgcoll) |> length == 1

end


@testset "Test cex trait of `ImageCollection`" begin
    #cexserializable, cex, fromcex
    u = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA083RN_0084")
    caption =  "folio 83 recto, natural light"
    lic = "CC-by-share"
    img = ImageRecord(u, caption, lic)

    imgcoll = image_collection([img])
    @test cexserializable(imgcoll)
end

@testset "Test julia collection traits of `ImageCollection" begin
    # iterate, length, eltype, filter, reverse
end


@testset "Test sliding windows on `ImageCollection`" begin
    
end