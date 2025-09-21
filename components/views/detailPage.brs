sub init()
    bindComponents()
    bindObservers()
end sub

sub bindComponents()
	m.image = m.top.findNode("image")
    m.title = m.top.findNode("title")
	m.network = m.top.findNode("network")
	m.rating = m.top.findNode("rating")
	m.genres = m.top.findNode("genres")
	m.description = m.top.findNode("description")
end sub

sub bindObservers()
    m.top.observeField("params", "onParamsChanged")
end sub

sub onParamsChanged()
    m.content = m.top.params?.content

	'Mocked content
	m.content = {
		description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an ..",
		genres: ["Drama", "Science-Fiction", "Thriller"],
		id: 1,
		image: {
			medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"
			original: "https://static.tvmaze.com/uploads/images/original_untouched/81/202627.jpg"
		},
		network: "CBS",
		rating: 6.5,
		title: "Under the Dome"
	}

	m.network = m.top.findNode("network")
	m.rating = m.top.findNode("rating")
	m.genres = m.top.findNode("genres")
	m.description = m.top.findNode("description")

	if m.content <> invalid then
		m.image.uri = m.content.image.medium
		m.title.text = m.content.title
		m.network.text = m.content.network
		m.rating.text = m.content.rating.toStr()
		m.description.text = m.content.description
		setGenres(m.content.genres)
	end if
end sub

sub setGenres(genres as object)
	if genres <> invalid and genres.count() > 0 then
		text = ""
		for i = 0 to genres.count() - 1
			text += genres[i]

			if i <> genres.count() - 1 then text += " · "
		end for

		m.genres.text = text
	end if
end sub

function onKeyEvent(key as String, press as Boolean) as Boolean
	handled = false
	
	if press then
		if key = "back" then
			m.global.navigationHandler.callFunc("showLastVisibleView")
			handled = true
		else if key = "OK" then
			if m.content <> invalid then
				m.top.getScene().videoMessage = {
					control: "play",
					params: {
						content: m.content
					}
				}
				handled = true
			end if
		end if
    end if
	return handled
end function