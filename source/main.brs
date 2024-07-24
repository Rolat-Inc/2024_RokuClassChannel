sub main()
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()

    voiceControlInput = CreateObject("roInput")
    voiceControlInput.SetMessagePort(m.port)
    voiceControlInput.enableTransportEvents()
    
    while(true)
        msg = wait(0, m.port)  
        msgType = type(msg)

        if msgType = "roSGScreen"
            if msg.isScreenClosed() then return
        else if type(msg) = "roInputEvent" then
            info = msg.getInfo()

            if info.type = "transport" then
                voiceInpuntResponse = scene.callFunc("handleTransport", info)
                voiceInpuntResponse.id = info.id
                ?"main :: Llegó un mensaje transport: ";voiceInpuntResponse
                voiceControlInput.EventResponse(voiceInpuntResponse)
            end if
        end if
    end while
end sub 