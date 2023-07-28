@testset "Test instantiating a Julia image object from a citable image service" begin
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)

    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")
    img = rgba_data(svc, imgurn, w = 900)
    @test size(img) == (1199, 900)
end