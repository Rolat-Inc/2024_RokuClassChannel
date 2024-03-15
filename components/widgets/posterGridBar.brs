sub init()
    m.posterGrid = m.top.findNode("posterGrid")
    setPosterGridContent()
end sub

sub setPosterGridContent()
    content = CreateObject("roSGNode", "ContentNode")
    
    homeSection = content.createChild("ContentNode")
    homeSection.contentType = "section"
    homeSection.title = "Home section"

    homeContent = homeSection.createChild("ContentNode")
    homeContent.SHORTDESCRIPTIONLINE1 = "Home"
    homeContent.HDPOSTERURL = "https://icon-library.com/images/white-home-icon-png/white-home-icon-png-21.jpg"

    homeContent = homeSection.createChild("ContentNode")
    homeContent.SHORTDESCRIPTIONLINE1 = "Home"
    homeContent.HDPOSTERURL = "https://icon-library.com/images/white-home-icon-png/white-home-icon-png-21.jpg"

    searchSection = content.createChild("ContentNode")
    searchSection.contentType = "section"
    homeSection.title = "Search section"

    searchContent = searchSection.createChild("ContentNode")
    searchContent.SHORTDESCRIPTIONLINE1 = "Search"
    searchContent.HDPOSTERURL = "https://icon-library.com/images/search-icon-white/search-icon-white-16.jpg"

    searchContent = searchSection.createChild("ContentNode")
    searchContent.SHORTDESCRIPTIONLINE1 = "Search"
    searchContent.HDPOSTERURL = "https://icon-library.com/images/search-icon-white/search-icon-white-16.jpg"

    m.posterGrid.content = content
    m.posterGrid.setFocus(true)
end sub