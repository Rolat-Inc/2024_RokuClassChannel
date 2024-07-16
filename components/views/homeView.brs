sub init()
	?"HomeView :: init"
	m.homeRowList = m.top.findNode("homeRowList")
	createRowlistContentTask()
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
	m.contentTask.control = "STOP"
    m.contentTask.unobserveField("output")
    m.contentTask = invalid
end sub