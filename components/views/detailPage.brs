sub init()
    bindComponents()
    bindObservers()
	setDesignProperties()
end sub

sub bindComponents()
    m.contentTitle = m.top.findNode("contentTitle")
	m.contentImage = m.top.findNode("contentImage")
	m.contentDescription = m.top.findNode("contentDescription")
	m.video = m.top.findNode("video")
end sub

sub bindObservers()
    m.top.observeField("params", "onParamsChanged")
end sub

sub setDesignProperties()
	setPlayIconProperties()
	setVideoProperties()
end sub

sub setPlayIconProperties()
	playIcon = m.top.findNode("playIcon")
	x = (m.contentImage.width - playIcon.width) / 2
	y = (m.contentImage.height - playIcon.height) / 2
	playIcon.translation = [x,y]
end sub

sub setVideoProperties()
	m.video.width = 1920/2
	m.video.height = 1080/2
end sub

sub onParamsChanged()
    m.content = m.top.params?.content

	if m.content <> invalid then
		m.contentTitle.text = m.content.title
		m.contentImage.uri = m.content.HDPOSTERURL
		m.contentDescription.text = m.content.description
	end if
end sub

sub playVideo()
	if m.content <> invalid then
		?"DP :: playVideo, url: ";m.content.videoUrl
		videoContent = CreateObject("RoSGNode", "ContentNode")
		videoContent.url = m.content.url
		videoContent.streamFormat = "mp4"

		m.video.visible = true
		m.video.content = videoContent
		m.video.control = "play"
		m.video.setFocus(true)
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press then
		if key = "back" then
			m.global.navigationHandler.callFunc("showLastVisibleView")
			handled = true
		else if key = "OK" then
			playVideo()
			handled = true
		end if
    end if
	return handled
end function