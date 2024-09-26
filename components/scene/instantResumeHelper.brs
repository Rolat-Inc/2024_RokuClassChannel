function customSuspend(arg as dynamic)
	?"MS :: customSuspend"
	m.top.allowBackgroundTask = true

	for each key in arg
		?" " key " = " arg[key]
	end for

	m.top.allowBackgroundTask = false
end function

function customResume(arg as dynamic)
	?"MS :: customResume"
	for each key in arg
		print " " key " = " arg[key]
	end for

	if arg.launchParams <> invalid
		launchParams = arg.launchParams
		if(launchParams.mediaType <> invalid) and (launchParams.contentId <> invalid)
			print "Deep Link parameters: Media Type "; launchParams.mediaType " Content Id "; launchParams.contentId
		end if
	end if

	if m.top.findNode("VideoPlayer").hasFocus() then
		m.top.videoMessage = {
			control: "resume",
		}
	end if
end function
