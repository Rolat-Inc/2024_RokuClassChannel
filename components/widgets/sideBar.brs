sub init()
	m.items = m.top.findNode("items")
	m.homeOption = m.top.findNode("homeOption")
	m.searchOption = m.top.findNode("searchOption")

	m.itemFocused = 0
	m.top.observeField("focusedChild", "onFocusedChildChange")
	setIconsContent()
end sub

sub onFocusedChildChange(event as object)
	if m.top.hasFocus() then
		m.items.getChild(m.itemFocused).setFocus(true)
		showItemTitles()
	end if
end sub

sub setIconsContent()
	m.homeOption.content = getIconItemContent("Home", "https://icon-library.com/images/white-home-icon-png/white-home-icon-png-21.jpg")
	m.searchOption.content = getIconItemContent("Search", "https://icon-library.com/images/search-icon-white/search-icon-white-16.jpg")
end sub

function getIconItemContent(title as String, posterUrl as String) as object
	content = createObject("RoSGNode","ContentNode")
	content.title = title
	content.HDPosterUrl = posterUrl

	return content
end function

sub showItemTitles(shouldShow = true as boolean)
	if m.items.getChildCount() > 0 then
		for i = 0 to m.items.getChildCount() -1
			item = m.items.getChild(i)
			if shouldShow then
				item.callFunc("showTitle")
			else
				item.callFunc("hideTitle")
			end if
		end for
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	if press then
		if key = "down" then
			if m.homeOption.hasFocus() then
				m.homeOption.setFocus(false)
				m.searchOption.setFocus(true)
				m.itemFocused++
				?"[ROLAT-1] setting m.itemFocused to ";m.itemFocused;" in SB :: OKE down()"

				handled = true
			end if
		else if key = "up" then 
			if m.searchOption.hasFocus() then
				m.searchOption.setFocus(false)
				m.homeOption.setFocus(true)
				m.itemFocused--

				handled = true
			end if
		else if key = "OK" or key = "right" then
			showItemTitles(false)
			m.top.getScene().callFunc("setFocusToCurrentView")
		end if
	end if

	return handled
end function
