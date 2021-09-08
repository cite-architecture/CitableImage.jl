using Base: padding
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



function box!(img, t,l,h,w; clr = RGB(0.0,0.0,1.0), padding=2)

    top = t - padding
    bottom = t + h + padding
    left = l - padding
    right = l + w + 2*padding

    # Draw top border:
    img[top:t, left:right] .= clr
    # Draw bottom border:
    img[bottom - padding:bottom, left:right] .= clr
    # Draw left border:
    img[top:bottom, left:l] .= clr
    # Draw right border:
    img[top:bottom, right - padding:right] .= clr

    img
end


boxcolor = RGB(0.5,0.0,0.5)

imgcp = copy(img)
box!(imgcp, 1200,200,200,1150; padding=5, clr=boxcolor)



Gray(rd)

println("HOld it.")


RGB(1.0,0.0,0.5) |> Gray

