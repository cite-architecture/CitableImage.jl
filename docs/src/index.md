# CitableImage.jl

> *Use URNs. to work with image services.*

The current version of the CitableImage package supports working with image servics using the IIIF protocol.


## Image server file system layout

The IIIF protocol requires you to know the specific path in the server's file system where the image can be found.  CitableImage expects a conventional mapping of URN components to the directory structure with the subdirectories for CITE namespace, collection, and version, beneath a base directory.  The name of image files should be the object identifer plus a `.tif` extension.  For example, CitableImage will format a request for an image identified by the URN `urn:cite2:hmt:vaimg.2017a:VA160VN_0662` for this directory structure:


```
BASE DIRECTORY
└── hmt
    └── vaimg
        └── 2017a
            └── VA160VN_0662.tif
```