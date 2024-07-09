sub init()
    m.audioGuide = CreateObject("roAudioGuide")
end sub

sub audioGuideRead(tts as string, flush = true as boolean, dontRepeat = true as boolean)
    m.audioGuide.say(tts, flush, dontRepeat)
end sub

sub audioGuideReadLines(textLinesArr as object, flush = true as boolean, allowRepeat = false as boolean)
    if utils_isNotEmptyArray(textLinesArr) then
        audioGuideRead(textLinesArr[0], flush, allowRepeat)
        for i = 1 to textLinesArr.count() - 1
            audioGuideRead(textLinesArr[i], false, allowRepeat)
        end for
    end if
end sub
