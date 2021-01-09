
"An instance of an IIIF image service."
struct IIIFservice
    baseurl
    directoryroot
end

function url(img::Cite2Urn, service::IIIFservice)
    service.baseurl * "?IIIF=" * service.directoryroot * "/" * image_directory(img) * "/" * objectcomponent(dropsubref(img)) * ".tif/full/2000,/0/default.jpg"   
end

function markdownImage(img::Cite2Urn, service::IIIFservice) #, width::Int   
    if hassubref(img) 
        "USE ROI"
    else
        "![image](" *  service.baseurl * "?IIIF=" * service.directoryroot * "/" * image_directory(img) * "/" * objectcomponent(dropsubref(img)) * ".tif/full/2000,/0/default.jpg)"  
    #  res1: String = "![image](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/200,/0/default.jpg)"
    end
end

function htmlImage(img::Cite2Urn, service::IIIFservice)
    #res3: String = "<img class=\"citeImage\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/!75,/0/default.jpg\" />"
    "TBA"
end

function linkedMarkdownImage(img, service) #, caption="Folio 12 recto of the Venetus A manuscript of the Iliad")
    #res7: String = "[![Folio 12 recto of the Venetus A manuscript of the Iliad](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/150,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013)"
    #res9: String = "[![Metrical summary of book 1](http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/pct:15.75,9.332,38.79,3.225/150,/0/default.jpg)](http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013@0.1575,0.09332,0.3879,0.03225)"
    "TBA"
end

function linkedHtmlImage(img, service) #, caption="Folio 12 recto of the Venetus A manuscript of the Iliad")
    #  String = "<a href=\"http://www.homermultitext.org/ict2/?urn=urn:cite2:hmt:vaimg.2017a:VA012RN_0013\"><img class=\"citeImage\" src=\"http://www.homermultitext.org/iipsrv?IIIF=/project/homer/pyramidal/deepzoom/hmt/vaimg/2017a/VA012RN_0013.tif/full/!,150/0/default.jpg\" /></a>"
    "TBA"
end