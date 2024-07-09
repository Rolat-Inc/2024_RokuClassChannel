function createTimer(duration as float, callbackFunction as string, repeat = false as boolean) as object
	timer = createObject("roSGNode", "Timer")
	timer.duration = duration
	timer.repeat = repeat
	if callbackFunction <> "" then timer.observeFieldScoped("fire", callbackFunction)

	return timer
end function

sub executeAfterDelay(func as string, delay = 0.5 as float)
	m.delayTimer = createTimer(delay, func)
	m.delayTimer.control = "start"
end sub

'utils_isValid: checking if value is not invalid or not uninitialized
'	@param value - as dynamic
'
'	@return as boolean - true/false
function utils_isValid(value as dynamic) as boolean
	return type(value) <> "<uninitialized>" and value <> invalid and type(value) <> "roInvalid"
end function

'utils_isArray: checking if value is array
'	@param value - as dynamic
'
'	@return as boolean - true/false
function utils_isArray(value as dynamic) as boolean
	return utils_isValid(value) and getInterface(value, "ifArray") <> invalid
end function


'utils_isNotEmptyArray: safely checking if provided input is an array and if it's not empty
'	@param input - as dynamic
'
'	@return as boolean - true/false
function utils_isNotEmptyArray(input as dynamic) as boolean
	return utils_isArray(input) and input.count() > 0
end function