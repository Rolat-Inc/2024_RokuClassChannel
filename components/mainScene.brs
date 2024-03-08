sub init()
	m.viewContainer = m.top.findNode("viewContainer")

	m.stackView = {}
	sideBar = m.top.findNode("sideBar")
	sideBar.setFocus(true)
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

sub setFocusToCurrentView()
	currentView = getCurrentView()

	if currentView <> invalid then 
		currentView.setFocus(true)
	end if
end sub

function getCurrentView() as object
	currentView = invalid
	if m.viewContainer.getChildCount() > 0 then currentView = m.viewContainer.getChild(0)

	return currentView
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	return handled
end function

' Next class:
' 1. Volver a enfocar la barra lateral desde las vistas
' 2. Interactuar / usar el keyboard