sub init()
    m.top.functionName = "execute"
end sub

sub execute()
    headers = {}
    headers["Authorization"] = "Bearer " + m.global.apiKey
    headers["accept"] = "application/json"
    imageConfig = getImageConfig(headers) 
    moviesResponse = getContent(headers) 

    content = createObject("RoSGNode", "ContentNode")

    for i = 0 to moviesResponse.results.count() - 1
        category = moviesResponse.results[i]
        if i mod 8 = 0
            section = content.createChild("ContentNode")
            section.title = "Daniela " + ((i / 8) + 1).toStr()
        end if 
        item = section.createChild("ContentNode")
        item.title = category.title
        item.HDPOSTERURL = imageConfig.baseUrl + "/" + imageConfig.rowlistSize + "/" + category.poster_path
    end for

    m.top.output = content 
end sub

function getImageConfig(headers = invalid)
    url = "https://api.themoviedb.org/3/configuration"
    response = makeHttpRequest(url, headers)
    config = invalid

    if response <> invalid  
        config = {
            baseUrl: response.images.base_url,
            rowlistSize: response.images.poster_sizes[2]
        }
    end if

    return config
end function

function getContent(headers = invalid)
    url = "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
    response = makeHttpRequest(url, headers)

    return response
end function 

function makeHttpRequest(url as String, headers = invalid)
    request = CreateObject("roUrlTransfer")
    request.setUrl(url)
    request.setCertificatesFile("common:/certs/ca-bundle.crt")
    request.initClientCertificates()
    request.setHeaders(headers)

    stringObject = request.getToString()
    response = parseJson(stringObject)

    return response
end function
