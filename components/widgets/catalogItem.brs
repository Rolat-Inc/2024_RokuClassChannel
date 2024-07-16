sub init()
    bindBaseComponents()
end sub

sub bindBaseComponents()
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.poster = m.top.findNode("poster")
    m.title = m.top.findNode("title")
end sub

sub onItemContentChanged()
    m.item = m.top.itemContent
    m.title.text = m.item.TITLE
    m.poster.uri = m.item.HDPOSTERURL
end sub