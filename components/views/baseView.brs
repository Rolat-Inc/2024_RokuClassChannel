sub init()
    ?"BaseView :: init"
    m.top.observeField("focusedChild", "onFocusedChildChange") 'onFocusedChildChange will be implemented in each view
end sub