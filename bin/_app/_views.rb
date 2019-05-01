require_relative "../functions"

content = <<~CONTENT
    doctype html
    html[amp]
        == slim :"global_partials/head",
                locals: { title: title, style: style, url: url }
        body
            h1.content = title
            == slim :"content_partials/pagination",
                locals: { page: page, pages: pages, pageUrls: pageUrls }
            - for post in content
                section.content
                    == post
CONTENT

head = <<~HEAD
    head
        == $amp_static_header
        == $amp_boiler

        title = title
        link[rel="canonical" href="\#{url}"]
        link[href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet"]
        style[amp-custom]
            == style
HEAD

notfound = <<~NOTFOUND
    doctype html
    html[amp]
        == slim :"global_partials/head",
                locals: { title: title, style: style, url: url }
        body
            div#not-found
                div.fof 404
                h1 Content not found.
NOTFOUND

pagination = <<~PAGINATION
    aside.content
        - unless pageUrls[0].nil?
            div.space-to-right
                a[href=pageUrls[0]] = "<<"
        - unless pageUrls[1].nil?
            div.space-to-right
                a[href=pageUrls[1]] = "<"
        div Displaying page \#{page} of \#{pages}.
        - unless pageUrls[2].nil?
            div.space-to-left
                a[href=pageUrls[2]] = ">"
        - unless pageUrls[3].nil?
            div.space-to-left
                a[href=pageUrls[3]] = ">>"
PAGINATION

post = <<~POST
    doctype html
    html[amp]
        == slim :"global_partials/head",
                locals: { title: title, style: style, url: url }
        body
            div.content
                == content
POST

results = <<~RESULTS
    doctype html
    html[amp]
        == slim :"global_partials/head",
                locals: { title: title, style: style, url: url }
        body
            h1.content Search Results
            == slim :"content_partials/pagination",
                locals: { page: page, pages: pages, pageUrls: pageUrls }
            - for post in content
                section.content
                    == post
RESULTS

search = <<~SEARCH
    doctype html
    html[amp]
        == slim :"global_partials/head",
                locals: { title: title, style: style, url: url }
        body
            div#search
                h1.content Search
                form[action="/search/query" method="POST"]
                    input[
                        class="search-input"
                        name="term"
                        placeholder="Search term"
                        type="text"
                    ]
                    input[
                        class="search-input"
                        name="when"
                        type="date"
                    ]
                    select[name="specificity"]
                        option[value="" selected=true] (All time)
                        option[value="year"] Year
                        option[value="month"] Month
                        option[value="year"] Day
                    input[
                        class="search-input"
                        name="submit"
                        type="submit"
                    ]
SEARCH

welcome = <<~WELCOME
    doctype html
    html[amp]
        == slim :"global_partials/head",
                locals: { title: title, style: style, url: url }
        body
            .main
                - content.each_with_index do |part, i|
                    div[id="content-\#{i}"]
                        == part
WELCOME

dirs = [
    "global_partials",
    "content_partials"
]

dirLoc = "$(pwd)/views"

makeDirs(dirs, dirLoc)

files = {
    "content.slim": content,
    "notfound.slim": notfound,
    "post.slim": post,
    "search.slim": search,
    "search_results.slim": results,
    "welcome.slim": welcome
}

makeFiles(files, dirLoc)

globalFiles = { "head.slim": head }

globalPartialsLoc = "#{dirLoc}/global_partials"

makeFiles(globalFiles, globalPartialsLoc)

contentFiles = { "pagination.slim": pagination }

contentPartialsLoc = "#{dirLoc}/content_partials"

makeFiles(contentFiles, contentPartialsLoc)
