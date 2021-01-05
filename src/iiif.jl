"An instance of an IIIF image service."
struct IIIFservice
    baseurl
    directoryroot
end


function url(urn::Cite2Urn, service:::IIIFservice)
    
end
# s"${baseUrl}IIIF=${imagePath}${imageID}.tif/${roiComponent}/${sizing}/0/default.jpg"
