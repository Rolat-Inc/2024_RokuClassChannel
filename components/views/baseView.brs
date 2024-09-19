sub init()
    m.top.observeField("focusedChild", "onFocusedChildChange") 'onFocusedChildChange will be implemented in each view
end sub

sub unmuteMainScene()
    m.top.getScene().callFunc("unmuteMainScene")
end sub

sub onFocusedChildChange()
end sub