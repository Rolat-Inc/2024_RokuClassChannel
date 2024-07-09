sub init()
    bindComponents()
    bindObservers()
end sub

sub bindComponents()
    m.lastFocusedId = ""
    m.miniKeyboard = m.top.findNode("miniKeyboard")
    m.button = m.top.findNode("button")
    m.resultsRowList = m.top.findNode("resultsRowList")
end sub

sub bindObservers()
    m.miniKeyboard.observeField("text", "onTextEntered")
    m.resultsRowList.observeField("rowItemSelected", "onRowItemSelectedChanged")
end sub

sub onFocusedChildChange()
    if m.top.hasFocus() then
        if m.lastFocusedId <> "" then
            m[m.lastFocusedId].setFocus(true)
        else
            m.miniKeyboard.setFocus(true)
            m.lastFocusedId = m.miniKeyboard.id
        end if
        m.global.audioGuideHandler.callFunc("audioGuideRead", "You are in Search View")
        unmuteMainScene()
    end if
end sub

sub onTextEntered(event as object)
    text = event.getData()
    
    if Len(text) = 3 then
        getResultsRowlistContent()
    end if
end sub

sub onRowItemSelectedChanged()
    rowItemSelected = m.resultsRowList.rowItemSelected ' [índice de la fila, índice del item seleccionado]
    itemSelectedContent = m.resultsRowList.content.getChild(rowItemSelected[0]).getChild(rowItemSelected[1])

    params = {
        content: itemSelectedContent
    }
    
    m.global.navigationHandler.callFunc("showView", "DetailPage", params)
    m.global.navigationHandler.callFunc("setFocusToCurrentView")
end sub

sub getResultsRowlistContent()
    m.searchResultsCNCreationTask = CreateObject("roSGNode", "SearchResultsCNCreationTask")
    m.searchResultsCNCreationTask.functionName = "createSearchResultsContentNode"
    m.searchResultsCNCreationTask.observeField("output", "onSearchResultsReceived")
    m.searchResultsCNCreationTask.control = "RUN"
end sub

sub onSearchResultsReceived(event as object)
    m.resultsRowList.content = event.getData()
    m.searchResultsCNCreationTask.control = "STOP"
    m.searchResultsCNCreationTask.unobserveField("output")
    m.searchResultsCNCreationTask = invalid
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
    
	if press then
        ?"SearchView :: onKeyEvent, key: ";key;" - press: ";press
		if key = "down" then
            if m.miniKeyboard.isInFocusChain() then
                m.button.setFocus(true)
                m.lastFocusedId = m.button.id
                handled = true
            end if
        else if key = "up" then
            if m.button.hasFocus() then
                m.miniKeyboard.setFocus(true)
                m.lastFocusedId = m.miniKeyboard.id
            end if
        else if key = "right" then
            if m.miniKeyboard.isInFocusChain() and m.resultsRowList.content <> invalid then
                m.resultsRowList.setFocus(true)
                m.lastFocusedId = m.resultsRowList.id
                handled = true
            end if
        else if key = "left" then
            if m.resultsRowList.isInFocusChain() then
                m.miniKeyboard.setFocus(true)
                m.lastFocusedId = m.miniKeyboard.id
                handled = true
            end if
        end if
    end if

    return handled
end function