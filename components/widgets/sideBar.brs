sub init()
	m.homeOption = m.top.findNode("homeOption")
	m.searchOption = m.top.findNode("searchOption")
	m.top.observeField("focusedChild", "onFocusedChildChange")
end sub

sub onFocusedChildChange(event as object)
	if m.top.hasFocus() then m.homeOption.setFocus(true)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false

	if press then
		if key = "down" then
			if m.homeOption.hasFocus() then
				m.homeOption.setFocus(false)
				m.searchOption.setFocus(true)
				handled = true
			end if
		else if key = "up" then 
			if m.searchOption.hasFocus() then
				m.searchOption.setFocus(false)
				m.homeOption.setFocus(true)
				
				handled = true
			end if
		end if
	end if

	return handled
end function
