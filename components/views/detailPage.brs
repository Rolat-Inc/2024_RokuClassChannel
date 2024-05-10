sub init()
    bindComponents()
    bindObservers()
end sub

sub bindComponents()
    m.contentTitle = m.top.findNode("contentTitle")
end sub

sub bindObservers()
    m.top.observeField("params", "onParamsChanged")
end sub

sub onParamsChanged()
    m.contentTitle.text = m.top.params?.contentTitle
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press
		if key = "back" then
			m.global.navigationHandler.callFunc("showLastVisibleView")
			handled = true
		end if
    end if
	return handled
end function