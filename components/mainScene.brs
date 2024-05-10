sub init()
	m.sideBar = m.top.findNode("sideBar")
	initializateNavigationHandler()
	m.sideBar.setFocus(true)
end sub

sub initializateNavigationHandler()
	m.global.addField("navigationHandler", "node", false) 
	m.global.setField("navigationHandler", m.top.findNode("navigationHanlder"))
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press
		if key = "back" or key = "left" then
			m.sideBar.setFocus(true)
			handled = true
		end if
    end if
	return handled
end function
