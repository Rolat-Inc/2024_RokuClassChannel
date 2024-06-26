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

sub onVideoStateChanged(event as object)
	state = event.getData()

	if state = "finished" then
		closeVideo()
	else if state = "playing" then
		if m.counterTimer.control = "start" then
			m.isSeekingInProgress = false
			stopCounterTimer()
		end if
	end if
end sub

sub onCounterTimerFired()
	m.transportInfo.counter += m.transportInfo.secondsToSeek * (m.transportInfo.multiplier / 2)
	?"New counter value: ";m.transportInfo.counter;" - multiplier: ";m.transportInfo.multiplier
end sub

sub stopCounterTimer()
	m.counterTimer.control = "stop"
	m.transportInfo.multiplier = 1
	m.speedMultiplierLabel.text = ""
end sub

sub playVideo(content as object)
	videoContent = CreateObject("RoSGNode", "ContentNode")
	videoContent.url = content.url
	videoContent.streamFormat = "mp4"
	videoContent.title = content.title

	m.top.visible = true
	m.top.content = videoContent
	m.top.control = "play"
	m.top.setFocus(true)
end sub

sub stopVideo()
	m.top.control = "stop"
	closeVideo()
end sub

sub closeVideo()
	m.top.visible = false
	m.top.content = invalid
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
				' si el video estaba pausado y hay un contador
					' resumir video
				' pero si el video se estaba reproduciendo entonces:
					stopVideo()
					handled = true
			end if
		else if key = "replay" then
			m.top.seek = 0
			handled = true
		else if key = "fastforward" or key = "rewind" then
			' Requerimientos: 
			' 1. Definir los segundos que representará X en nuestra aplicación: 10
			' 2. Definir los múliplos de X: 2X, 4X y 8X
			'
			' Implementación
			' 1. Pausar video
			' 2. Tener un contador en el que voy a almacenar la cantidad de tiempo que el video se moverá de posición
			' 3. Tener un timer que incremente el valor cada segundo
			' 4. Controlar las veces que el usuario presiona RW o FF para incrementar el contador y el multiplicador
			
			' Validaciones
			' 1. Que la posición en donde fue pausado el video + el valor del contador sea > 0 y < que la duración del video
			executeSeeking(key)
		else if key = "play" or key ="OK" or key = "pause" then
			' Mostrar imagen de la película
			' Si existía un valor en el contador, hacer video.seek hacia la nueva posición (en la que pausó el video + contador)
				' Reiniciar multiplicador
			' Si no existía el contador y el video estaba pausado entonces resumir el video, si no estaba pausado entonces pausarlo
		else if key = "options" then
			' Dar el foco a componente para opciones de accessibility 
		end if
    end if
	return handled
end function

' Cuando el video termine, llevar al usuario a la página de detalle