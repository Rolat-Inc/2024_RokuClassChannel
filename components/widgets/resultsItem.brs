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
    m.focusBorder.height = m.contentImage.height 
    m.contentImage.height = m.contentImage.height  - (m.borderPadding * 2)
    m.top.findNode("container").translation = [m.borderPadding, m.borderPadding]
end sub

sub onWidthChanged()
    m.contentImage.width = m.top.width - (m.borderPadding * 2)
    m.top.findNode("titleBackground").width = m.top.width - (m.borderPadding * 2)
    m.contentTitle.width = m.top.width - (m.borderPadding * 2)
    m.contentDescription.width = m.top.width - (m.borderPadding * 2)
    m.focusBorder.width = m.top.width

    ?"item has focus: ";m.top.itemHasFocus
    ?"focus border widht - height: ";m.focusBorder.width;" - ";m.focusBorder.height;" - visible: ";m.focusBorder.visible
    ?"contentImage widht - height: ";m.contentImage.width;" - ";m.contentImage.height
    ?"container translation: ";m.top.findNode("container").translation
end sub

sub onItemContentChanged(event as object)
    m.itemContent = event.getData()

    m.contentImage.uri = m.itemContent?.FHDPOSTERURL
    m.contentTitle.text = m.itemContent?.title
    m.contentDescription.text = m.itemContent?.description
end sub

sub onItemHasFocusChanged()
    ?"itemHasFocus: ";m.top.itemHasFocus
    m.focusBorder.visible = m.top.itemHasFocus
    m.contentDescription.visible = m.top.itemHasFocus
end sub