sub main(args as object)
    ?"RolatProject :: main, args: ";args
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("MainScene")
    screen.show()

    voiceControlInput = CreateObject("roInput")
    voiceControlInput.SetMessagePort(m.port)
    voiceControlInput.enableTransportEvents()

    ' DeepLink → Launch
    deepLinkObject = getDeepLinkObject(args)
    if deepLinkObject <> invalid then scene.deepLink = deepLinkObject
    
    while(true)
        msg = wait(0, m.port)  
        msgType = type(msg)

        if msgType = "roSGScreen"
            if msg.isScreenClosed() then return
        else if type(msg) = "roInputEvent" then
            info = msg.getInfo()

            if info.type = "transport" then
                ?"main :: Llegó un mensaje transport: ";voiceInpuntResponse
                voiceInpuntResponse = scene.callFunc("handleTransport", info)
                voiceInpuntResponse.id = info.id
                voiceControlInput.EventResponse(voiceInpuntResponse)
            else
                deepLinkObject = getDeepLinkObject(info)
                ?"main :: input deep link: ";deepLinkObject
                if deepLinkObject <> invalid then scene.deepLink = deepLinkObject
            end if
        end if
    end while
end sub

function getDeepLinkObject(args as object)
    deepLinkObject = invalid
    if args <> invalid and args.doesExist("contentId") and args.doesExist("mediaType") then
        deepLinkObject = {
            contentId: args.contentId,
            mediaType: args.mediaType
        }
    end if

    return deepLinkObject
end function