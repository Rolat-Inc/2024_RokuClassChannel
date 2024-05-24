sub init()
    bindComponents()
    bindObservers()
	setDesignProperties()
end sub

sub bindComponents()
    m.contentTitle = m.top.findNode("contentTitle")
	m.contentImage = m.top.findNode("contentImage")
	m.contentDescription = m.top.findNode("contentDescription")
end sub

sub bindObservers()
    m.top.observeField("params", "onParamsChanged")
end sub

sub setDesignProperties()
	playIcon = m.top.findNode("playIcon")
	x = (m.contentImage.width - playIcon.width) / 2
	y = (m.contentImage.height - playIcon.height) / 2
	playIcon.translation = [x,y]
end sub

sub onParamsChanged()
    content = m.top.params?.content

	if content <> invalid then
		m.contentTitle.text = content.title
		m.contentImage.uri = content.HDPOSTERURL
		m.contentDescription.text = content.description
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press
		if key = "back" then
			m.global.navigationHandler.callFunc("showLastVisibleView")
			handled = true
		end if
    end if
	return handled
end function