require "yaml"

def add_new(name)
    if name.nil? || name.length == 0
        puts "Invalid custom page name." and return
    end

    cwd = Dir.pwd
    downcasedName = name.downcase
    custom = YAML.load_file("#{cwd}/customlist.yml")
    custom.select! { |c| c["file"] != downcasedName }

    custom << {
        "name" => downcasedName,
        "path" => "/#{downcasedName}",
        "title" => name,
        "content" => [ "#{downcasedName}.md" ]
    }

    customView = <<~VIEW
        doctype html
        html[amp]
            == slim :"global_partials/head",
                    locals: { title: title, style: style, url: url }
            body
                .main
                    - content.each_with_index do |part, i|
                        div[id="content-\#{i}"]
                            == part
    VIEW

    customStyle = <<~STYLE
        @import "_common";

        html, body {
            .base-page;
        }

        .main {
            @center-vert();
            @full-page();

            h1 {
                @fs5();
                @fw300();
                text-align: center;
            }
        
            h2 {
                @fs2();
                @fw300();
            }
        }
    STYLE

    `echo '#{custom.to_yaml}' > #{cwd}/customlist.yml`
    `mkdir #{cwd}/#{downcasedName}`
    `echo '# #{name}' > #{cwd}/#{downcasedName}/#{downcasedName}.md`
    `echo '#{customView}' > #{cwd}/views/#{downcasedName}.slim`
    `echo '#{customStyle}' > #{cwd}/src/styles/#{downcasedName}.less`
    `gulp shrink`
end