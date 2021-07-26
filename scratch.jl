using HTTP
using ImageMagick
using ImageShow

function uforw(wdth)
    string("http://www.homermultitext.org/iipsrv?OBJ=IIP,1.0&FIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA001RN_0002.tif&RGN=0.002852,0.001418,0.9939,0.9952&WID=", wdth, "&CVT=JPEG")
end

function imgfromurl(u)
    IOBuffer(HTTP.get(u).body) |> ImageMagick.load
end

img = uforw(2000) |> imgfromurl

ImageShow.gif(img)


using Images
graymask = RGB(0.8, 0.8, 0.8)

rd = RGB(1.0,0.0,0.0)

sum(rd, graymask)

function fade(clr,drkness)
    return(RGB(clr.r * drkness, clr.g * drkness, clr.b * drkness))
end

function rgbtogray(clr)
    return(Gray(clr))
end

fadedred = fade(rd, 1.9)

fadedred |> typeof
rd.b
img |> typeof

img

using Images
tweakable = copy(img)

tweakable[1000:1500,250:1000] = rgbtogray.(tweakable[1000:1500,250:1000])

tweakable

Gray(rd)

println("HOld it.")

imgx = Array(reshape(range(0,stop=1,length=10^4), 100, 100))
img_c = imgx[51:70, 21:70]

RGB(1.0,0.0,0.5) |> Gray