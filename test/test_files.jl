@testset "Test implementation of `LocalImageFiles`" begin
    imgsrc = localimages("data")
    @test imgsrc isa LocalImageFiles

    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.15,0.10,0.10,0.1")
    @test isfile(CitableImage.imgpath(imgsrc, imgurn, extension = "jpg"))

    flatsrc = LocalImageFiles(joinpath(pwd(), "data"), false)
    @test flatsrc isa LocalImageFiles
    flatdirimg = Cite2Urn("urn:cite2:citeecod:codsang250imgs.v1:sg250_478_477_0@0.2458,0.3005,0.07813,0.02664")
    @test isfile(CitableImage.imgpath(flatsrc, flatdirimg, extension = "jpg"))
    data  = rgb_data(flatsrc, flatdirimg)
    @test size(data) == (2000, 459)

    data500  = rgb_data(flatsrc, flatdirimg, ht = 500)
    @test size(data500) == (500, 114)

end