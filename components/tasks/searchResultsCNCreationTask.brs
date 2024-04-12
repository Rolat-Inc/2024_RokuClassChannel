sub init()
end sub

sub createSearchResultsContentNode()
    content = CreateObject("roSGNode", "ContentNode")
    response = getMockedData()

    if response <> invalid then
        categories = response.categories
        for i = 0 to categories.count() - 1
            category = categories[i]
            rowContent = content.createChild("ContentNode")
            rowContent.title = category.name

            for j = 0 to category.items.count() - 1
                item = category.items[j]
                itemContent = rowContent.createChild("ContentNode")
                itemContent.title = item.title
                itemContent.FHDPOSTERURL = item.image
                itemContent.description = item.description
                itemContent.contentType = item.type
            end for
        end for
    end if

    m.top.output = content
end sub

function getMockedData()
    mockedData = {
        categories: [
            {
                name: "Movies",
                items: [
                    {
                        title: "Shrek",
                        image: "https://media.ambito.com/p/01eb77fef00df683ab1e49f372596862/adjuntos/239/imagenes/040/616/0040616822/shrekjpg.jpg",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                        type: "movie"
                    },
                    {
                        title: "Encanto"
                        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYzQrgu87RH19R4JJma9cJjLp3fnRj_NziztKXQZ8p7Q&s",
                        description: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
                        type: "movie"
                    },
                    {
                        title: "Monsters Inc.",
                        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj7c5hdL_IwfhW1WL0XQluxAXBMNX9x58N9cRI2s5oZg&s",
                        description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        type: "movie"
                    }
                ],
            },
            {
                name: "Series",
                items: [
                    {
                        title: "Stranger things",
                        image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM-9pPYtL_QTDEw2VucGhvbwxccxo69gmc0O94_DKiTg&s",
                        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                        type: "series"
                    },
                    {
                        title: "Grey's anatomy",
                        image: "https://cloudfront-us-east-1.images.arcpublishing.com/infobae/XFK5UGVL2JHNJOIGTFOYJ7BTRE.jpg",
                        description: "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        type: "series"
                    }
                ]
            }
        ]
    }

    ' {
    '     name: "Recently watched",
    '     items: [
    '         {
    '             title: "Stranger things",
    '             image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSM-9pPYtL_QTDEw2VucGhvbwxccxo69gmc0O94_DKiTg&s",
    '             description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    '             type: "series"
    '         },
    '         {
    '             title: "Encanto"
    '             image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYzQrgu87RH19R4JJma9cJjLp3fnRj_NziztKXQZ8p7Q&s",
    '             description: "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ",
    '             type: "movie"
    '         }
    '     ]
    ' }

    return mockedData
end function
