sub init()
    ?"BaseView :: init"
    m.top.observeField("focusedChild", "onFocusedChildChange") 'onFocusedChildChange will be implemented in each view
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
    ?"BaseView :: onKeyEvent"
	handled = false


	return handled
end function