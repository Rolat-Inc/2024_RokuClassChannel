sub init()
	m.viewContainer = m.top.findNode("viewContainer")

	m.stackView = {}
	m.top.findNode("sideBar").setFocus(true)
end sub

sub showView(viewName as string)
	if m.viewContainer.getChildCount() > 0 then m.viewContainer.removeChildIndex(0)

	if m.stackView.doesExist(viewName) then
		view = m.stackView[viewName]
	else
		view = CreateObject("roSGNode", viewName)
		m.stackView[viewName] = view
	end if

	m.viewContainer.appendChild(view)
end sub
