
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
    @test markdownImage(alpha, svc; ht=250, caption="Iliad 1") == expectedCaption
end

@testset "Compose markdown for embedded image with link" begin
    ict = "http://www.homermultitext.org/ict2/?"
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)

    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")
    expected = "[![Folio 12 recto)](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/150,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013)"
    actual = linkedMarkdownImage(ict, img, svc; ht=150, caption="Folio 12 recto")
    @test actual == expected
    #
    #res7: String = "[![Folio 12 recto](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/150,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013)"

    alpha = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.2096,0.2112,0.1617,0.01892")
    alphaActual = linkedMarkdownImage(ict, alpha, svc; ht=200, caption="Iliad 1")
    alphaExpected = "[![Iliad 1)](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/pct:20.96,21.12,16.17,1.892/200,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.2096,0.2112,0.1617,0.01892)"
    @test alphaActual == alphaExpected
end

@testset "Test html markup" begin
    ict = "http://www.homermultitext.org/ict2/?"
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)

    img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.2964,0.6418,0.3163,0.01744")
    expected = "<img class=\"citeImage\" alt=\"image\"  src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:29.64,64.18,31.63,1.744/2000,/0/default.jpg\" />"
    @test htmlImage(img,svc) == expected


    expectedlink = "<a href=\"http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA001RN_0002@0.2964,0.6418,0.3163,0.01744\"><img class=\"citeImage\" alt=\"image\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif/pct:29.64,64.18,31.63,1.744/500,/0/default.jpg\"/></a>"

    @test  linkedHtmlImage(ict,urn,svc) == expectedlink
end