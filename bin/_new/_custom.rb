require "yaml"

def add_new(name)
    if name.nil? || name.length == 0
        puts "Invalid custom page name." and return
    end

    cwd = Dir.pwd
    downcasedName = name.downcase
    custom = YAML.load_file("#{cwd}/customlist.yml")
    controllers.select! { |c| c["file"] != downcasedName }

    custom << {
        "name" => downcasedName,
        "path" => "/#{downcasedName}",
        "title" => name,
        "content" => [ "#{downcasedName}.md" ]
    }

    `echo '#{custom.to_yaml}' > #{cwd}/customlist.yml`
    `mkdir #{cwd}/#{downcasedName}`
    `echo '# #{name}' > #{cwd}/#{downcasedName}/#{downcasedName}.md`
    `cp #{cwd}/views/welcome.slim #{cwd}/views/#{downcasedName}.slim`
    `cp #{cwd}/src/styles/welcome.less #{cwd}/src/styles/#{downcasedName}.less`
    `gulp shrink`
end