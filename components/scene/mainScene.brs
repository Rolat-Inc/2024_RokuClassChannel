sub init()
	m.sideBar = m.top.findNode("sideBar")
	initializateNavigationHandler()
	initializateAudioGuide()
	m.top.muteAudioGuide = true
	m.audioGuideHandler.callFunc("audioGuideRead", "Welcome to Roku class channel by Rolat", false)
	m.sideBar.setFocus(true)
	' executeAfterDelay("unmuteMainScene", 2)
end sub

' ---------------------------------
' Navigation handler
' ---------------------------------

sub initializateNavigationHandler()
	m.global.addField("navigationHandler", "node", false) 
	m.global.setField("navigationHandler", m.top.findNode("navigationHanlder"))
end sub

' ' ---------------------------------
' ' Audio Guide
' ' ---------------------------------
sub initializateAudioGuide()
	?"MS :: initializateAudioGuide"
	m.audioGuideHandler = CreateObject("roSgNode", "AudioGuideHandler")
	m.global.addField("audioGuideHandler", "node", false) 
	m.global.setField("audioGuideHandler", m.audioGuideHandler)
end sub

sub unmuteMainScene()
	m.top.muteAudioGuide = false
end sub

' ---------------------------------
' Key handling
' ---------------------------------

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
