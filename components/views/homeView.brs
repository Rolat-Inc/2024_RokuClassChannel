sub init()
	?"HomeView :: init"
	m.border = m.top.findNode("border")
	m.button = m.top.findNode("button")
	m.poster = m.top.findNode("testPoster")
	m.buttonLabel = m.top.findNode("label")
end sub

sub onFocusedChildChange(event as object)
	if m.top.hasFocus() then m.border.setFocus(true)

	if m.border.hasFocus() then
		m.border.width = 610
		m.border.height = 360
		m.poster.translation = [5,5]
	else
		m.border.width = 600
		m.border.height = 350
		m.poster.translation = [0,0]
	end if

	if m.button.hasFocus() then
		m.button.color = "#FFFFFF"
		m.buttonLabel.color = "#000000"
	else
		m.button.color = "#000000"
		m.buttonLabel.color = "#FFFFFF"
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press then
		if key = "down" then
			if m.border.hasFocus() then
				m.border.setFocus(false)
				m.button.setFocus(true)
				handled = true
			end if
		else if key = "up" then
			if m.button.hasFocus() then
				m.button.setFocus(false)
				m.border.setFocus(true)
				handled = true
			end if
		else if key = "OK" then
			if m.button.hasFocus() then
				'Lo que hace cuando presionan OK en el botón
				handled = true
			end if
		end if
	end if

	return handled
end function