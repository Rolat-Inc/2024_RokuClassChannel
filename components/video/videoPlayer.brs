sub init()
	bindComponents()
	bindVariables()
	setVideoProperties()
	bindObservers()
end sub

sub bindComponents()
	m.counterTimer = m.top.findNode("counterTimer")
	m.speedMultiplierLabel = m.top.findNode("speedMultiplierLabel")
end sub

sub bindVariables()
	m.transportInfo = {
		secondsToSeek: 5,
		multiplier: 1,
		maxMultiplier: 8
		counter: 0
	}
	m.lastKey = ""
	m.isSeekingInProgress = false
end sub

sub setVideoProperties()
	' TODO: Get this info from device
	m.top.width = 1920
	m.top.height = 1080
	m.top.trickPlayBar.filledBarBlendColor = "0x066F6C"
end sub

sub bindObservers()
	m.top.observeField("state", "onVideoStateChanged")
	m.counterTimer.observeField("fire", "onCounterTimerFired")
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
		else if incomingMessage.control = "resume" then
			if m.top.content <> invalid then
				setResumePoint(m.top.content.id)
				m.top.control = "play"
			end if
		end if
	end if
end sub

sub onVideoStateChanged(event as object)
	state = event.getData()

	if state = "finished" then
		closeVideo()
	else if state = "playing" then
		if m.counterTimer.control = "start" then
			m.isSeekingInProgress = false
			stopCounterTimer()
		end if
	else if state = "stopped" then 
		updateBookmarkVideoPostion(m.top.content.id, m.top.position)
		m.top.control = "stop"
	end if
end sub

sub onCounterTimerFired()
	m.transportInfo.counter += m.transportInfo.secondsToSeek * (m.transportInfo.multiplier / 2)
end sub

sub stopCounterTimer()
	m.counterTimer.control = "stop"
	m.transportInfo.multiplier = 1
	m.transportInfo.counter = 0
	m.speedMultiplierLabel.text = ""
end sub

sub playVideo(content as object)
	videoContent = CreateObject("RoSGNode", "ContentNode")
	videoContent.id = content.id
	videoContent.url = content.url
	videoContent.streamFormat = "mp4"
	videoContent.title = content.title

	m.top.visible = true
	m.top.content = videoContent
	setResumePoint(content.id)
	m.top.control = "play"
	m.top.setFocus(true)
end sub

sub setResumePoint(contentId as string)
	resumePoint = getBookmarkPosition(contentId)
	if resumePoint > 0 then
		m.top.seek = resumePoint
	end if
end sub

sub stopVideo()
	m.top.control = "stop"
	updateBookmarkVideoPostion(m.top.content.id, m.top.position)
	closeVideo()
end sub

sub closeVideo()
	m.top.visible = false
	m.top.content = invalid
	m.global.navigationHandler.callFunc("setFocusToCurrentView")
end sub

sub executeSeeking(key as string)
	if m.top.state <> "paused" then m.top.control = "pause"
	m.speedMultiplierLabel.text = abs(m.transportInfo.multiplier).toStr() + "X"
	if m.isSeekingInProgress = false then m.counterTimer.control = "start"

	if key = "fastforward" then
		if m.lastKey <> "" and m.lastKey = "rewind" then
			m.transportInfo.multiplier = 1
			m.speedMultiplierLabel.text = ""
		else
			if m.transportInfo.multiplier = m.transportInfo.maxMultiplier or m.transportInfo.multiplier < 0 then
				m.transportInfo.multiplier = 1
			else if m.transportInfo.multiplier > 0 then
				m.transportInfo.multiplier = 2 * (m.transportInfo.multiplier)
			end if
		end if
	else
		if m.lastKey <> "" and m.lastKey = "fastforward" then
			m.transportInfo.multiplier = -1
			m.speedMultiplierLabel.text = ""
		else
			if m.transportInfo.multiplier > 0 then
				m.transportInfo.multiplier = -1
			else
				m.transportInfo.multiplier = 2 * (m.transportInfo.multiplier)
			end if
		end if
	end if

	m.lastKey = key
	m.isSeekingInProgress = true
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press then
		if key = "back" then
			if m.top.isInFocusChain() then
				stopVideo()
				handled = true
			end if
		else if key = "replay" then
			m.top.seek = 0
			handled = true
		else if key = "fastforward" or key = "rewind" then
			executeSeeking(key)
		end if
    end if
	return handled
end function
