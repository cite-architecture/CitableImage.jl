@testset "Test image source abstraction" begin
    struct FakeSource <: AbstractImageSource end
    fakeSource = FakeSource()
    imgurn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.15,0.10,0.10,0.1")
    @test_throws DomainError imagedata(fakeSource, imgurn)
end

