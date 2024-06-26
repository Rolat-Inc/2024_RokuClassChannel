sub init()
    bindComponents()
    bindObservers()
	setDesignProperties()
	m.seconds = 0
end sub

sub bindComponents()
	m.counterLabel = m.top.findNode("counterLabel")
    m.contentTitle = m.top.findNode("contentTitle")
	m.contentImage = m.top.findNode("contentImage")
	m.contentDescription = m.top.findNode("contentDescription")
	m.counterTimer = m.top.findNode("counterTimer")
end sub

sub bindObservers()
    m.top.observeField("params", "onParamsChanged")
	m.counterTimer.observeField("fire", "onCounterTimerFired")
end sub

sub setDesignProperties()
	setPlayIconProperties()
end sub

sub setPlayIconProperties()
	playIcon = m.top.findNode("playIcon")
	x = (m.contentImage.width - playIcon.width) / 2
	y = (m.contentImage.height - playIcon.height) / 2
	playIcon.translation = [x,y]
end sub

sub onCounterTimerFired()
	m.seconds++
	m.counterLabel.text = m.seconds.toStr()
	if m.seconds = 1000 then m.counterTimer.control = "stop"
end sub

sub onParamsChanged()
    m.content = m.top.params?.content

	if m.content <> invalid then
		m.contentTitle.text = m.content.title
		m.contentImage.uri = m.content.HDPOSTERURL
		m.contentDescription.text = m.content.description
		m.counterTimer.control = "start"
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press then
		if key = "back" then
			m.global.navigationHandler.callFunc("showLastVisibleView")
			handled = true
		else if key = "OK" then
			if m.content <> invalid then
				m.top.getScene().videoMessage = {
					control: "play",
					params: {
						content: m.content
					}
				}
				handled = true
			end if
		end if
    end if
	return handled
end function