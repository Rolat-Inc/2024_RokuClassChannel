sub init()
	m.video = m.top.findNode("video")
	setVideoProperties()
end sub

sub setVideoProperties()
	' TODO: Get this info from device
	m.video.width = 1920
	m.video.height = 1080
end sub

sub playVideo(content as object)
	videoContent = CreateObject("RoSGNode", "ContentNode")
	videoContent.url = content.url
	videoContent.streamFormat = "mp4"
	videoContent.title = content.title

	m.video.visible = true
	m.video.content = videoContent
	m.video.control = "play"
	m.video.setFocus(true)
end sub

sub stopVideo()
	m.video.control = "stop"
	m.video.visible = false
	m.video.content = invalid
	m.global.navigationHandler.callFunc("setFocusToCurrentView")
end sub

'STRUCTURE OF THE MESSAGE
' control: To determine what function to execute	* Mandatory
' params: Params to be sent to the function 		* Optional
sub onIncomingMessageChanged(event as object)
	incomingMessage = event.getData()
	?"VP :: onIncomingMessageChanged: ";incomingMessage

	if incomingMessage <> invalid then
		if incomingMessage.control = "play" then
			playVideo(incomingMessage.params.content)
		end if
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press then
		if key = "back" then
			if m.video.isInFocusChain() then
				stopVideo()
				handled = true
			end if
		end if
    end if
	return handled
end function