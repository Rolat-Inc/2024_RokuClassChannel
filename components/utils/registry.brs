function registryRead(key as string, section = "default" as string) as object
    registrySection = createObject("roRegistrySection", section)

    if registrySection.exists(key) then return registrySection.read(key)

    return invalid
end function

sub registryWrite(key as string, value as object, section = "default" as string)
    registrySection = createObject("roRegistrySection", section)
    registrySection.write(key, value)
    registrySection.flush()
end sub

sub registryDelete(key as string, section = "default" as string)
    registrySection = createObject("roRegistrySection", section)
    registrySection.delete(key)
    registrySection.flush()
end sub

'---------------------
'Bookmarks
'---------------------
sub loadBookmaks()
    m.bookmarks = []

    bookmarks = registryRead("bookmarks", "channelBookmarks")

    if bookmarks <> invalid m.bookmarks = ParseJson(bookmarks)
end sub

sub updateBookmarkVideoPostion(contentId as string, position as integer)
    if position = invalid or position <= 0 or contentId = "" then return

    bookmarkFound = false
    if m.bookmarks = invalid then loadBookmaks()

    for each bookmark in m.bookmarks
        if bookmark.id = contentId then
            bookmark.position = position
            bookmarkFound = true
            exit for
        end if
    end for     

    if not bookmarkFound then
        bookmark = {
            id: contentId,
            position: position
        }

        m.bookmarks.push(bookmark)
    end if

    ?"Registry :: saving position ";position;" for video id: ";contentId

    saveBookmarks()
end sub

sub saveBookmarks()
    if m.bookmarks <> invalid then registryWrite("bookmarks", formatJSON(m.bookmarks), "channelBookmarks")
end sub

function getBookmarkPosition(contentId as string) as integer
    position = 0
    
    if contentId <> "" then
        if m.bookmarks = invalid then loadBookmaks()

        for each bookmark in m.bookmarks
            if bookmark.id = contentId then
                position = bookmark.position
                exit for
            end if
        end for
    end if

    return position
end function

sub cleanBookmarks()
    m.bookmarks = []
    saveBookmarks()
end sub