
@testset "Test IIIF implementation of `AbstractImageSource`" begin
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)
    @test isa(svc, IIIFservice)

    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.15,0.10,0.10,0.1")
    img = rgb_data(svc, imgurn, w = 600)
    @test typeof(img)== Matrix{RGB{N0f8}}
    @test size(img) == (799, 600)
end