
@testset "Convert ROI string to float values" begin
    roi = "0.12345,0.22345,0.32345,0.42345"
    floats = CitableImage.roiFloats(roi)
    @test floats[1] ≈ 12.345
    @test floats[2] ≈ 22.345
    @test floats[3] ≈ 32.345
    @test floats[4] ≈ 42.345
end