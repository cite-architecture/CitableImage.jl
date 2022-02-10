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
    expected = "#!datamodels\nCollection|Model|Label|Description\nurn:cite2:hmt:vaimg.2017a:|urn:cite2:cite:datamodels.v1:imagemodel|Image collection with 1 image\n\n#!citeproperties\nProperty|Label|Type|Authority list\nurn:cite2:hmt:vaimg.2017a.urn:|URN|Cite2Urn|\nurn:cite2:hmt:vaimg.2017a.label:|Label|String|\nurn:cite2:hmt:vaimg.2017a.rights:|Rights|String|\n\n#!citedata\nurn|caption|rights\nurn:cite2:hmt:vaimg.2017a:VA083RN_0084|folio 83 recto, natural light|CC-by-share"
    @test cex(imgcoll) == expected
    @test fromcex(cex(imgcoll), ImageCollection) == imgcoll


end

@testset "Test julia collection traits of `ImageCollection" begin
    # iterate, length, eltype, filter, reverse
    #slidingwindow
    f = joinpath(pwd(), "data", "sample-imgs.cex")

    coll = fromcex(f, ImageCollection, FileReader)
    @test eltype(coll) == ImageRecord
    @test length(coll) == 10
    @test typeof(collect(coll))  <: Vector
    filtered = filter(p -> contains(label(p),"2 recto"), coll) |> collect
    @test length(filtered) == 1

    lasturn = Cite2Urn("urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f005v")
    reversed = reverse(coll)
    @test urn(reversed[1]) == lasturn

    windoid =  slidingwindow(coll)
    @test urn(windoid[1][1]) == Cite2Urn("urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f001r")
    @test urn(windoid[end][2]) == Cite2Urn("urn:cite2:citebl:burney86imgs.v1:burney_ms_86_f005v")

end

