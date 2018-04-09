puts "\t--- Helpers: Index ---"

def index_locals
    indexParts = [ "#{$index_root}/index.md" ]

    lc = "landing-content"
    ch = "contentHidden"

    {
        title: "Sinatra, AMPed!",
        content: $utils.parse_md(indexParts)[0],
        contentAttrs: {
            "[class]": "content.#{ch} ? '#{lc} hidden' : '#{lc} shown'",
            "class": "#{lc} shown",
            "on": "tap:AMP.setState({ content: { #{ch}: !content.#{ch}} })",
            "role": "Main",
            "tabindex": "0"
        },
        style: $utils.load_css("index")
    }
end