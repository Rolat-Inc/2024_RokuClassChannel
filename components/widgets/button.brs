sub init()
    m.top.uri = "pkg:/images/button.png"
    m.icon = m.top.findNode("icon")
    m.layoutGroup = m.top.findNode("layoutGroup")
    m.textLabel = m.top.findNode("textLabel")
end sub

'before setting text - calculating text's width and setting it with paddings to the badge frame accordingly
sub onTextChanged()
    text = m.top.text
    if text <> invalid and text.len() > 0 then
        m.textLabel.text = text
        
        padding = 15
        textLength = m.textLabel.boundingRect().width
        textHeight = m.textLabel.boundingRect().height

        m.top.width = textLength + m.icon.width + (padding * 4)
        m.top.height = textHeight + (padding * 2)
        m.layoutGroup.translation = [padding * 2, padding * 2]

        if m.top.color <> invalid then m.top.blendColor = m.top.color
    else
        m.textLabel.text = ""
        m.top.width = 0
    end if
end sub

