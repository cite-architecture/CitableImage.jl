
@testset "Test instantiating a service" begin
    baseurl = "http://www.homermultitext.org/iipsrv"
    root = "/project/homer/pyramidal/deepzoom"
    svc = IIIFservice(baseurl, root)
    @test isa(svc, IIIFservice)
end