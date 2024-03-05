sub init()
	m.items = m.top.findNode("items")
	m.homeOption = m.top.findNode("homeOption")
	m.searchOption = m.top.findNode("searchOption")
	m.top.observeField("focusedChild", "onFocusedChildChange")

	m.settingsOption = CreateObject("roSGNode", "IconItem")
	m.top.appendChild(m.settingsOption)
end sub

sub onFocusedChildChange(event as object)
	if m.top.hasFocus() then
		m.homeOption.setFocus(true)
		' TODO: Mostrar los títulos de todos los ítems cuando se recupere el foco
	end if
end sub

sub hideItemTitles()
	if m.items.getChildCount() > 0 then
		for i = 0 to m.items.getChildCount() -1
			item = m.items.getChild(i)
			item.callFunc("hideTitle")
		end for
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	?"SideBar :: onKeyEvent. Press: ";press;" - key: ";key
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
		else if key = "OK" then
			hideItemTitles()
			' Dar el foco a la vista
			
		end if
	end if

	return handled
end function
