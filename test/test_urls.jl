
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

    alpha = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.2096,0.2112,0.1617,0.01892")
    expectedRoi = "![image](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/pct:20.96,21.12,16.17,1.892/2000,/0/default.jpg)"
    @test markdownImage(alpha, svc) == expectedRoi

    expectedCaption = expectedCaption = "![Iliad 1](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/pct:20.96,21.12,16.17,1.892/250,/0/default.jpg)"
    @test markdownImage(alpha, svc, 250, "Iliad 1") == expectedCaption
end

@testset "Compose markdown for embedded image with link" begin
    ict = "http://www.homermultitext.org/ict2/?"
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)

    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")
    expected = "[![Folio 12 recto)](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/150,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013)"
    actual = linkedMarkdownImage(ict, img, svc, 150, "Folio 12 recto")
    @test actual == expected
    #
    #res7: String = "[![Folio 12 recto](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/150,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013)"

    alpha = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.2096,0.2112,0.1617,0.01892")
    alphaActual = linkedMarkdownImage(ict, alpha, svc, 200, "Iliad 1")
    alphaExpected = "[![Iliad 1)](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/pct:20.96,21.12,16.17,1.892/200,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.2096,0.2112,0.1617,0.01892)"
    @test alphaActual == alphaExpected
end