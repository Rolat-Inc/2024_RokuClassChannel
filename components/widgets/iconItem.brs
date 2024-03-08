sub init()
	m.icon = m.top.findNode("icon")
	m.title = m.top.findNode("title")
	m.option = m.top.findNode("option")

	m.top.observeField("focusedChild", "onFocusedChildChange")
end sub

sub onFocusedChildChange()
	if m.top.hasFocus() then
		updateChildrenColor("#ffffff")
		m.top.getScene().callFunc("showView", m.top.viewName)
	else
		updateChildrenColor("#999999")
	end if
end sub

sub updateChildrenColor(colorCode as string)
	m.icon.blendColor = colorCode
	m.title.color = colorCode
end sub

sub hideTitle()
	m.option.removeChild(m.title)
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	'Si el usuario presiona OK o derecha, dar el foco a la vista
	return handled
end function