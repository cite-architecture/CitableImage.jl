
@testset "Construct IIIF requests" begin
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)

    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")
    expected = "http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/2000,/0/default.jpg"
    @test url(img,svc) == expected
end


@testset "Construct markdown links" begin
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)

    urn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")
    expected = "![image](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/2000,/0/default.jpg)"
    @test markdownImage(urn, svc) == expected
end