sub init()
    m.borderPadding = 5
    bindComponents()
    setDesignProperties()
end sub

sub bindComponents()
    m.focusBorder = m.top.findNode("focusBorder")
    m.contentImage = m.top.findNode("contentImage")
    m.contentTitle = m.top.findNode("contentTitle")
    m.contentDescription = m.top.findNode("contentDescription")
end sub

sub setDesignProperties()
    m.focusBorder.height = m.contentImage.height + (m.borderPadding * 2)
    m.contentImage.height = m.contentImage.height  - (m.borderPadding * 2)
    m.contentImage.translation = [m.borderPadding, m.borderPadding]
end sub

sub onWidthChanged()
    m.contentImage.width = m.top.width - (m.borderPadding * 2)
    m.top.findNode("titleBackground").width = m.top.width - (m.borderPadding * 2)
    m.contentTitle.width = m.top.width - (m.borderPadding * 2)
    m.contentDescription.width = m.top.width - (m.borderPadding * 2)
    m.focusBorder.width = m.top.width
end sub

sub onItemContentChanged(event as object)
    m.itemContent = event.getData()

    m.contentImage.uri = m.itemContent?.FHDPOSTERURL
    m.contentTitle.text = m.itemContent?.title
    m.contentDescription.text = m.itemContent?.description
end sub

sub onItemHasFocusChanged()
    if m.top.itemHasFocus then
        m.focusBorder.color = "0xFFFFFF"
    else
        m.focusBorder.color = "0xFFFFFF00"
    end if
    m.contentDescription.visible = m.top.itemHasFocus
  
end sub