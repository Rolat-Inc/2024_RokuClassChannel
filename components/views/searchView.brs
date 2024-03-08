sub init()
    ?"SearchView :: init"
    m.keyboard = m.top.findNode("keyboard")
end sub

sub onFocusedChildChange()
    ?"SearchView :: onFocusedChildChange: ";m.top.hasFocus()
    if m.top.hasFocus() then m.keyboard.setFocus(true)
end sub