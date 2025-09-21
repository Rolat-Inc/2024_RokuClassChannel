sub init()
    m.top.uri = "pkg:/images/badge_frame.9.png"
    m.top.height = 30
    m.textLabel = m.top.findNode("textLabel")
end sub

'before setting text - calculating text's width and setting it with paddings to the badge frame accordingly
sub onTextChanged()
    text = m.top.text
    if text <> invalid and text.len() > 0 then
        m.textLabel.text = text
        
        padding = 10
        textLength = m.textLabel.boundingRect().width
        textHeight = m.textLabel.boundingRect().height

        m.top.width = textLength + (padding * 2)
        m.top.height = textHeight + (padding * 2)
        m.textLabel.translation = [padding, padding]

    else
        m.textLabel.text = ""
        m.top.width = 0
    end if
end sub

