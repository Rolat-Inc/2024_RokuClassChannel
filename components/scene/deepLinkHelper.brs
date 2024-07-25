sub onDeepLinkChanged(event as object)
    data = event.getData()

    if validateDeepLink(data) then
        handleDeepLink(data.contentId, data.mediaType)
    end if
end sub

function validateDeepLink(data as object) as boolean
    if data <> invalid then
        contentId = data.contentId
        mediaType = data.mediaType

        return contentId <> invalid and mediaType <> invalid and getSupportedMediaTypes().doesExist(mediaType)
    end if

    return false
end function

function getSupportedMediaTypes() as object
    return {
        "movie": "movie"
    }
end function

'-------------------------
' Media type handlers
'-------------------------
sub handleDeepLink(contentId as string, mediaType as string)
    if mediaType = "movie" then
        handleMovieDeepLink(contentId)
    else if mediaType = "series" then
        handleSeriesDeepLink(contentId)
    end if
end sub

sub handleMovieDeepLink(contentId)
    ?"DeepLinkHelper :: handleMovieDeepLink: ";contentId
    if m.global.homeMoviesList <> invalid then
        playbackItem = getPlaybackItem(contentId, m.global.homeMoviesList)
        handlePlaybackItem(playbackItem)
    else
        m.contentTask = CreateObject("roSGNode", "createRowlistContentTask")
        m.contentTask.observeField("output", "onContentReceived")
        m.contentTask.control = "RUN"
    end if
end sub

sub handleSeriesDeepLink(contentId)
    ' Implement season behavior logic
end sub

'-------------------------
' Complementary functions
'-------------------------
sub onContentReceived()
    contentId = m.top.deepLink.contentId 
    moviesList = m.contentTask.output
    m.global.homeMoviesList = moviesList
    stopContentTask()
	playbackItem = getPlaybackItem(contentId, moviesList)
    handlePlaybackItem(playbackItem)
end sub

function getPlaybackItem(contentId as string, moviesList as object)
    playbackItem = invalid

    for i = 0 to moviesList.getChildCount() -1 ' Sections
        section = moviesList.getChild(i)
        for j = 0 to section.getChildCount() -1 'Items in each section
            item = section.getChild(j)

            if item.id = contentId then
                playbackItem = item
                exit for
            end if
        end for
    end for

    return playbackItem
end function

sub handlePlaybackItem(playbackItem as object)
    if playbackItem <> invalid then return

    createDetailPage(playbackItem)
    playContent(playbackItem)
end sub

function createDetailPage(playbackItem as object)
    params = {
        content: playbackItem
    }
    m.global.navigationHandler.callFunc("showView", "DetailPage", params)
end function

sub playContent(playbackItem as object)
    m.top.getScene().videoMessage = {
        control: "play",
        params: {
            content: playbackItem
        }
    }
end sub

sub stopContentTask()
	m.contentTask.control = "STOP"
    m.contentTask.unobserveField("output")
    m.contentTask = invalid
end sub
