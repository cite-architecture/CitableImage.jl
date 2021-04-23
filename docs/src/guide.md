# User guide


## Instantiate a IIIF service

Instantiate a service with a base URL and a path to the root directory for the service.

```@example eg
using CitableImage
baseurl = "http://www.homermultitext.org/iipsrv"
root = "/project/homer/pyramidal/deepzoom"
service = IIIFservice(baseurl, root)
```    


## Compose an IIIF request 

Compute a IIIF request for an image identified by URN.


```@example eg
using CitableObject
img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")

iifrequest = url(img, service)
```


## Compose a markdown display of an image

Format the request for inclusion in a markdown document.  Here, we'll use the optional height parameter to set the result image's size in pixels.

```@example eg
markdownImage(img, service, 200)
```
```@eval
using CitableImage
baseurl = "http://www.homermultitext.org/iipsrv"
root = "/project/homer/pyramidal/deepzoom"
service = IIIFservice(baseurl, root)

using CitableObject
img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")

using Markdown
Markdown.parse(markdownImage(img, service, 200))
```

## Compose a markdown display linked to an image citation tool

We need an additional parameter for the ImageCitationTool to link to.  In this exmaple, we'll opt to include both a height in pixels and a caption to embed in the markdown.


```@example eg
ict = "http://www.homermultitext.org/ict2/?"
linkedMarkdownImage(ict, img, service; ht=100, caption="folio 12 recto")
```

The output is linked to the configured image citation tool.

```@eval
using CitableImage
baseurl = "http://www.homermultitext.org/iipsrv"
root = "/project/homer/pyramidal/deepzoom"
service = IIIFservice(baseurl, root)

using CitableObject
img = Cite2Urn("urn:cite2:hmt:vaimg.2017a:VA012RN_0013")

ict = "http://www.homermultitext.org/ict2/?"
using Markdown
Markdown.parse(linkedMarkdownImage(ict, img, service; ht=100, caption="folio 12 recto"))
```