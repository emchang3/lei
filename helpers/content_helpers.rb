puts "\t--- Helpers: Content ---"

require "yaml"

def page_slice(contentList, pageParam)
    page = pageParam != 0 ? pageParam : 1
    pages = (contentList.length / 5.0).ceil
    firstIndex = (page - 1) * 5
    lastIndex = page * 5

    {
        contentList: contentList[firstIndex..lastIndex],
        page: page,
        pages: pages
    }
end

def eject_banned(contentList)
    classified = YAML.load_file($banlist)

    contentList - classified
end