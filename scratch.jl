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


s = "http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/2000,/0/default.jpg"

#{scheme}://{server}{/prefix}/{identifier}/{region}/{size}/{rotation}/{quality}.{format}

modded = replace(s, r"full\/[^/]*" => "full/100,0")
w = 100
src = "full/2000,/0/default.jpg"
mod2 = replace(src, r"full/[^/]+" => "full/$w,")

roi = "tif/pct:20.35,20.76,17.26,2.451/2000,/0/default.jpg"
modroi = replace(roi, r"tif/([^/]+)/.+" => s"tif/\1/")
string(modroi, w, ",/0/default.jpg")
msg = "#Hello# from Julia";
replace(msg, r"#(.+)# from (?<from>\w+)" => s"FROM: \g<from>; MESSAGE: \1")
