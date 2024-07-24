function handleTransport(eventInfo as object)
    ?"VoiceControl :: handleTransport: ";eventInfo
    command = eventInfo.command
    eventResponse = { status: "unhandled" }

    if command = "play" then
        m.top.videoMessage = {
            control: "play",
            params: {
                content: getMockedVideoContent()
            }
        }

        eventResponse.status = "success"
    end if

    return eventResponse
end function

function getMockedVideoContent()
    mockedVideoContent = createObject("RoSGNode", "ContentNode") 
					
    mockedVideoContent.url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"
    mockedVideoContent.streamFormat = "mp4"
    mockedVideoContent.title = "Tears of Steel - Mocked"

    return mockedVideoContent
end function