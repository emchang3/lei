puts "\t--- Helpers: Index ---"

def index_locals
    content = [
        "#{$index_root}/above-fold.md",
        "#{$index_root}/lei.md",
        "#{$index_root}/internals.md"
    ]

    {
        title: "靁 - léi",
        content: $utils.parse_md(content),
        style: $utils.load_css("index")
    }
end