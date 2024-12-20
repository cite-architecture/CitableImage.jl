"An instance of an IIIF image service."
struct IIIFservice <: AbstractImageSource
    baseurl
    directoryroot
end

"""Retrieve RGB data for an image identified by URN from a IIIF service.
$(SIGNATURES)
"""
function rgb_data(src::IIIFservice, img::Cite2Urn; extension = "tif", w::Int=2000)::Matrix{RGB{N0f8}}
    f = Downloads.download(url(img, src, w = w, extension = extension)) 
    img = load(f)
	rm(f)
	img
end


"""Compose URL for retrieving an image from an IIIF service.
$(SIGNATURES)

# Arguments

- `url` `Cite2Urn` for an image.
- `service` `IIIFService`
- `ht` Height of resulting image in pixels.
- `extension` Extension for file name on server.
"""
function url(img::Cite2Urn, service::IIIFservice; w::Int=2000, extension = "tif")
    if hassubref(img)
        pct = pctString(img)
        service.baseurl * "?IIIF=" * service.directoryroot * "/" * subdirectory(img) * "/" * objectcomponent(dropsubref(img)) * ".$(extension)/$(pct)/$(w),/0/default.jpg"   
    else
        service.baseurl * "?IIIF=" * service.directoryroot * "/" * subdirectory(img) * "/" * objectcomponent(dropsubref(img)) * ".$(extension)/full/$(w),/0/default.jpg"   
    end
end

"""Compose markdown wrapping an IIIF URL for retrieving an image.

$(SIGNATURES)

# Arguments

- `img` `Cite2Urn` for an image.
- `service` `IIIFService`
- `ht` Height of resulting image in pixels.

"""
function markdownImage(img::Cite2Urn, service::IIIFservice; w::Int=2000, caption::AbstractString="image") 
    #if hassubref(img) 
        #pct = pctString(img)
        pieces = [
        "![",
        caption,
        "](",
        url(img, service; w = w),
        ")"
        ]
        join(pieces)
end

"""Compose markdown wrapping IIIF URL for image linked to an image citation tool installation.

$(SIGNATURES)

# Arguments

- `ict` URL of an instance of the CiteArchitecture ImageCitationTool.
- `img` `Cite2Urn` for an image.
- `service` `IIIFService`
- `w` Width of resulting image in pixels.
- `caption` Caption to embed in resulting linked markdown string.
"""
function linkedMarkdownImage(ict::AbstractString, img, service; w::Int=500, caption::AbstractString="image", extension = "tif")
    
    scaledimensions = hassubref(img) ? pctString(img) : "full"
    pt1 = "[![" * caption * "](" *  service.baseurl * "?IIIF=" * service.directoryroot * "/"
    pt2 = subdirectory(img) * "/" * objectcomponent(dropsubref(img)) 
    pt3 =  ".$(extension)/" * scaledimensions  * "/$(w),/0/default.jpg)]"
    pt4 = "(" * ict * "urn=$(img.urn))"
    join([pt1, pt2, pt3, pt4], "")
end


"""Compose HTML `img` element for image retrieved from an IIIF service.

$(SIGNATURES)
"""
function htmlImage(img::Cite2Urn, service::IIIFservice; w = 2000, caption::AbstractString="image")
    #res3: String = "<img class=\"citeImage\" alt=\"image\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/!75,/0/default.jpg\" />"
    
    
    pieces = [
        "<img class=\"citeImage\"",
        " alt=\"",
        caption,
        "\" ",
        " src=\"",
        url(img, service, w = w),
        "\" />"
    ]
    join(pieces)
end


"""Compose markdown wrapping IIIF URL for image linked to an image citation tool installation.

$(SIGNATURES)
"""
function linkedHtmlImage(ict::AbstractString, img, service;  w::Int=500, caption::AbstractString="image") #, caption="Folio 12 recto of the Venetus A manuscript of the Iliad")
    #  String = "<a href=\"http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013\"><img class=\"citeImage\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/!,150/0/default.jpg\" /></a>"
    pieces = [
    "<a href=\"",
    ict,
    "urn=",
    img,
    "\"><img class=\"citeImage\"",
    " alt=\"",
    caption,
    "\" src=\"",
    url(img,service; w=w),
    "\"/></a>"
    ]
    join(pieces)
end