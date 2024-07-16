sub init()
    bindComponents()
end sub

sub bindComponents()
    m.line = m.top.findNode("rectangle")
    m.section = m.top.findNode("section")
end sub

sub onContentChanged(msg as Object)
    data =  msg.getData()
    m.section.text = data.title
end sub