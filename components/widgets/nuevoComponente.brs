sub init()
    m.option = m.top.createChild("LayoutGroup")
    m.option.id = "option"
    m.option.layoutDirection = "horiz"
    m.option.itemSpacings = [10]

    m.icon = m.option.createChild("Poster")
    m.icon.id = "icon"
    m.icon.height = 31
    m.icon.width = 31
    m.icon.blendColor = "#999999"
    m.icon.uri = "https://icon-library.com/images/white-home-icon-png/white-home-icon-png-21.jpg"

    m.title = m.option.createChild("Label")
    m.title.id = "title"
    m.title.color = "#999999"
    m.title.text = "Settings"
end sub

sub onFocusedChildChange()
    ' Agregamos un hijo más 
end sub