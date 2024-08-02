sub init()
	?"HomeView :: init"
	m.homeRowList = m.top.findNode("homeRowList")
	m.homeRowList.observeField("rowItemSelected", "onRowItemSelectedChanged")
	if m.global.homeMoviesList <> invalid then
		m.homeRowList.content = m.global.homeMoviesList
	else
		createRowlistContentTask()
	end if
end sub

sub onFocusedChildChange()
	if m.top.hasFocus() then
		m.homeRowList.setFocus(true)
		m.global.audioGuideHandler.callFunc("audioGuideRead", "You are in Home View")
		unmuteMainScene()
	end if
end sub

sub createRowlistContentTask()
	m.contentTask = CreateObject("roSGNode", "createRowlistContentTask")
	m.contentTask.observeField("output", "onContentReceived")
	m.contentTask.control = "RUN"
end sub

sub onContentReceived()
	m.homeRowList.content = m.contentTask.output
	m.global.homeMoviesList = m.contentTask.output
	m.contentTask.control = "STOP"
    m.contentTask.unobserveField("output")
    m.contentTask = invalid
end sub

sub onRowItemSelectedChanged()
    rowItemSelected = m.homeRowList.rowItemSelected
    itemSelectedContent = m.homeRowList.content.getChild(rowItemSelected[0]).getChild(rowItemSelected[1])

    params = {
        content: itemSelectedContent
    }
    
    m.global.navigationHandler.callFunc("showView", "DetailPage", params)
    m.global.navigationHandler.callFunc("setFocusToCurrentView")
end sub