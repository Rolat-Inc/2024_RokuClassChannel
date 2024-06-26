sub init()
	m.video = m.top.findNode("video")
	setVideoProperties()
	bindObservers()
end sub

sub setVideoProperties()
	' TODO: Get this info from device
	m.video.width = 1920
	m.video.height = 1080
	m.video.trickPlayBar.filledBarBlendColor = "0x066F6C"
end sub

sub bindObservers()
	m.video.observeField("state", "onVideoStateChanged")
end sub

sub onVideoStateChanged(event as object)
	state = event.getData()

	if state = "finished" then
		closeVideo()
	end if
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
	closeVideo()
end sub

sub closeVideo()
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
				' si el video estaba pausado y hay un contador
					' resumir video
				' pero si el video se estaba reproduciendo entonces:
					stopVideo()
					handled = true
			end if
		else if key = "replay" then
			m.video.seek = 0
			handled = true
		else if key = "fastforward" or key = "rewind" then
			' Requerimientos: 
			' 1. Definir los segundos que representará X en nuestra aplicación: 10
			' 2. Definir los múliplos de X: 2X, 5X y 10X
			'
			' Implementación
			' 1. Pausar video
			' 2. Tener un contador en el que voy a almacenar la cantidad de tiempo que el video se moverá de posición
			' 3. Tener un timer que incremente el valor cada segundo
			' 4. Controlar las veces que el usuario presiona RW o FF para incrementar el contador y el multiplicador
			
			' Validaciones
			' 1. Que la posición en donde fue pausado el video + el valor del contador sea > 0 y < que la duración del video 
		else if key = "play" or key ="OK" or key = "pause" then
			' Mostrar imagen de la película
			' Si existía un valor en el contador, hacer m.video.seek hacia la nueva posición (en la que pausó el video + contador)
			' Si no existía el contador y el video estaba pausado entonces resumir el video, si no estaba pausado entonces pausarlo
		else if key = "options" then
			' Dar el foco a componente para opciones de accessibility 
		end if
    end if
	return handled
end function

' Cuando el video termine, llevar al usuario a la página de detalle