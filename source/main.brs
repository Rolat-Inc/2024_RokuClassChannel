sub main()
    screen= CreateObject("roSGScreen")
    m.port= CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene= screen.CreateScene("MainScene")
    screen.show()
    while(true)
        msg= wait(0, m.port)
        msgType= type(msg)

        if msgType= "roSGScreen"
            if msg.isScreenClosed() then return 
        end if
    end while
end sub 