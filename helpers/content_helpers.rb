puts "\t--- Helpers: Content ---"

require "yaml"

def page_slice(contentList, page)
    firstIndex = (page - 1) * 5
    lastIndex = page * 5

    contentList[firstIndex..lastIndex]
end

def eject_banned(contentList)
    classified = YAML.load_file($banlist)

    contentList - classified
end