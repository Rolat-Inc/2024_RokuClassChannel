sub init()
end sub

sub createSearchResultsContentNode()
    content = createObject("RoSGNode", "ContentNode") 
    response = getContent()

    if response <> invalid and response.count() > 0 then
        for i = 0 to response.count() - 1
            section = content.createChild("ContentNode")
            category = response.categories[i]
            section.title = response.categories[i].name

            for j = 0 to category.videos.count() -1
                videoInfo = category.videos[j]
                itemContent = section.createChild("ContentNode")
            
                itemContent.title = videoInfo.title
                itemContent.secondaryTitle = videoInfo.subtitle
                itemContent.HDPOSTERURL = videoInfo.thumb
                itemContent.description = videoInfo.description
                itemContent.setFields({
                    contentUrl: videoInfo.sources
                })
            end for
        end for
    end if

    m.top.output = content 
end sub

function getContent()
    request = CreateObject("roUrlTransfer")
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.AddHeader("X-Roku-Reserved-Dev-Id", "")
    request.InitClientCertificates()
    request.SetUrl("https://cdn-media.brightline.tv/recruiting/roku/testapi.json")
    responseApi = ParseJson(request.GetToString()) 

    return responseApi
end function