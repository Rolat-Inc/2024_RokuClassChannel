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

sub onIconItemContentChanged(event as object)
	content = event.getData()
	m.title.text = content.title
	m.icon.uri = content.HDPosterUrl
end sub

sub updateChildrenColor(colorCode as string)
	m.icon.blendColor = colorCode
	m.title.color = colorCode
end sub

sub hideTitle()
	m.option.removeChild(m.title)
end sub

sub showTitle()
	m.option.appendChild(m.title)
end sub
