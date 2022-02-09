@testset "Test image source abstraction" begin
    struct FakeSource <: AbstractImageSource end
    fakeSource = FakeSource()
    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.15,0.10,0.10,0.1")
     @test_throws DomainError imagedata(fakeSource, imgurn)
end



    #url = "http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/pct:15.0,10.0,10.0,5.0/600,/0/default.jpg"
   #urn:cite2:citeecod:codsang250imgs.v1:sg250_478_477_0@0.2458,0.3005,0.07813,0.02664
