sub init()
	m.sideBar = m.top.findNode("sideBar")
	initializateNavigationHandler()
	initializateAudioGuide()
	m.top.muteAudioGuide = true
	m.audioGuideHandler.callFunc("audioGuideRead", "Welcome to Roku class channel by Rolat", false)
	setApiKey()
	m.global.addField("homeMoviesList", "node", false) 
	m.sideBar.setFocus(true)
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

' ' ---------------------------------
' ' ApiKey
' ' ---------------------------------
sub setApiKey()
	m.global.addFields({apiKey : "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MmY2NDJjMGQyZjkwOTA0ZDc5YzhkYjJlM2IxOGM5MSIsInN1YiI6IjY1MzZjNjkyOTQ2MzE4MDBlMzgyNTE3OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.zgFNEulspcbr8Sy7shuUWaCAVaxCtQmWaWkoNsZzVaU"})
end sub 

' ' ---------------------------------
' ' Instant Resume
' ' ---------------------------------
function customSuspend(arg as dynamic)
	?"MS :: customSuspend"
	m.top.allowBackgroundTask = true

	for each key in arg
		?" " key " = " arg[key]
	end for

	m.top.allowBackgroundTask = false
end function

function customResume(arg as dynamic)
	?"MS :: customResume"
	for each key in arg
		print " " key " = " arg[key]
	end for

	if arg.launchParams <> invalid
		launchParams = arg.launchParams
		if(launchParams.mediaType <> invalid) and (launchParams.contentId <> invalid)
			print "Deep Link parameters: Media Type "; launchParams.mediaType " Content Id "; launchParams.contentId
		end if
	end if

	if m.top.findNode("VideoPlayer").hasFocus() then
		m.top.videoMessage = {
			control: "resume",
		}
	end if
end function

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
