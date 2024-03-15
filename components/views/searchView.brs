sub init()
    ?"SearchView :: init"
    m.pinPad = m.top.findNode("pinPad")
    m.button = m.top.findNode("button")

    m.pinPad.observeField("pin", "onPinPadTextChanged")
end sub

sub onFocusedChildChange()
    ?"SearchView :: onFocusedChildChange: ";m.top.hasFocus()
    if m.top.hasFocus() then m.pinPad.setFocus(true)
end sub

sub onPinPadTextChanged(event as object)
    pinText = event.getData()
    ?"SV :: onPinPadTextChanged: ";pinText

    if len(pinText) = m.pinPad.pinLength then
        m.button.setFocus(true)
        m.pinPad.unobserveField("pin")
    end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
    
	if press then
		if key = "down" then
            if m.pinPad.isInFocusChain() then
                m.button.setFocus(true)
                handled = true
            end if
        else if key = "up" then
            if m.button.hasFocus() then
                m.pinPad.setFocus(true)
            end if
        end if
    end if

    return handled
end function