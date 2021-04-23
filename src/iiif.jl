
"An instance of an IIIF image service."
struct IIIFservice
    baseurl
    directoryroot
end


"""Compose IIIF URL for retrieving an image.
$(SIGNATURES)

# Arguments

- `url` `Cite2Urn` for an image.
- `service` `IIIFService`
- `ht` Height of resulting image in pixels.
"""
function url(img::Cite2Urn, service::IIIFservice, ht::Int=2000)
    if hassubref(img)
        pct = pctString(img)
        service.baseurl * "?IIIF=" * service.directoryroot * "/" * image_directory(img) * "/" * objectcomponent(dropsubref(img)) * ".tif/$(pct)/$(ht),/0/default.jpg"   
    else
        service.baseurl * "?IIIF=" * service.directoryroot * "/" * image_directory(img) * "/" * objectcomponent(dropsubref(img)) * ".tif/full/$(ht),/0/default.jpg"   
    end
end

"""Compose markdown wrapping an IIIF URL for retrieving an image.

$(SIGNATURES)

# Arguments

- `img` `Cite2Urn` for an image.
- `service` `IIIFService`
- `ht` Height of resulting image in pixels.

"""
function markdownImage(img::Cite2Urn, service::IIIFservice, ht::Int=2000, caption::AbstractString="image") 
    if hassubref(img) 
        pct = pctString(img)
        "![$(caption)](" *  service.baseurl * "?IIIF=" * service.directoryroot * "/" * image_directory(img) * "/" * objectcomponent(dropsubref(img)) * ".tif/$(pct)/$(ht),/0/default.jpg)"  
    else
        "![$(caption)](" *  service.baseurl * "?IIIF=" * service.directoryroot * "/" * image_directory(img) * "/" * objectcomponent(dropsubref(img)) * ".tif/full/$(ht),/0/default.jpg)"  
    
    end
end

"""Compose markdown wrapping IIIF URL for image linked to an image citation tool installation.

$(SIGNATURES)

# Arguments

- `ict` URL of an instance of the CiteArchitecture ImageCitationTool.
- `img` `Cite2Urn` for an image.
- `service` `IIIFService`
- `ht` Height of resulting image in pixels.
- `caption` Caption to embed in resulting linked markdown string.
"""
function linkedMarkdownImage(ict::AbstractString, img, service; ht::Int=500, caption::AbstractString="image")
    scaledimensions = hassubref(img) ? pctString(img) : "full"
    pt1 = "[![" * caption * ")](" *  service.baseurl * "?IIIF=" * service.directoryroot * "/"
    pt2 = image_directory(img) * "/" * objectcomponent(dropsubref(img)) 
    pt3 =  ".tif/" * scaledimensions  * "/$(ht),/0/default.jpg)]"
    pt4 = "(" * ict * "urn=$(img.urn))"
    join([pt1, pt2, pt3, pt4], "")
end





# Functions for future versions:


function htmlImage(img::Cite2Urn, service::IIIFservice)
    #res3: String = "<img class=\"citeImage\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/!75,/0/default.jpg\" />"
    @warn "htmlImage ot yet implemented"
    nothing
end
function linkedHtmlImage(img, service) #, caption="Folio 12 recto of the Venetus A manuscript of the Iliad")
    #  String = "<a href=\"http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013\"><img class=\"citeImage\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/!,150/0/default.jpg\" /></a>"
    @warn "linkedHtmlImage ot yet implemented"
    nothing
end