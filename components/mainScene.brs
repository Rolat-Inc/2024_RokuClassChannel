sub init()
	m.viewContainer = m.top.findNode("viewContainer")

	m.stackView = {}
	m.lastVisibleView = invalid
	m.sideBar = m.top.findNode("sideBar")
	m.sideBar.setFocus(true)
end sub

sub showView(viewName as string, params = invalid as object)
	if m.viewContainer.getChildCount() > 0 then
		m.lastVisibleView = m.viewContainer.getChild(0).subtype()
		m.viewContainer.removeChildIndex(0)
	end if

	if m.stackView.doesExist(viewName) then
		view = m.stackView[viewName]
	else
		view = CreateObject("roSGNode", viewName)
		m.stackView[viewName] = view
	end if

	if params <> invalid then view.params = params

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

sub setFocusToSideBar()
	m.sideBar.setFocus(true)
end sub

sub showLastVisibleView()
	if m.lastVisibleView <> invalid then
		showView(m.lastVisibleView)
		setFocusToCurrentView()
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press
		if key = "back" or key = "left" then
			setFocusToSideBar()
			handled = true
		end if
    end if
	return handled
end function
