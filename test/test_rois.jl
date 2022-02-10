
@testset "Convert ROI string to float values" begin
    roi = "0.12345,0.22345,0.32345,0.42345"
    floats = CitableImage.roiFloats(roi)
    @test floats[1] ≈ 12.345
    @test floats[2] ≈ 22.345
    @test floats[3] ≈ 32.345
    @test floats[4] ≈ 42.345
end

@testset "Compose IIIF percent expressions" begin
    roi = "0.12345,0.22345,0.32345,0.42345"
    expected = "pct:12.345,22.345,32.345,42.345" 
    @test CitableImage.pctString(roi) == expected

    urn = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.12345,0.22345,0.32345,0.42345")
    @test CitableImage.pctString(urn) == expected
end

@testset "Test rectangular RoI abstraction" begin
    struct FakeRect <: AbstractRectRoi end
    fakeRect = FakeRect()
    @test_throws DomainError top(fakeRect)
    @test_throws DomainError bottom(fakeRect)
    @test_throws DomainError left(fakeRect)
    @test_throws DomainError right(fakeRect)
    @test_throws DomainError h(fakeRect)
    @test_throws DomainError w(fakeRect)
end