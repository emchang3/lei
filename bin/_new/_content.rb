require "yaml"

def add_new(name)
    if name.nil? || name.length == 0
        puts "Invalid custom page name." and return
    end

    name = name.split(" ")[0]
    downcasedName = name.downcase
    capitalizedName = name.capitalize
    controllerName = "#{capitalizedName}Controller"

    contentController = <<~CONTENT
        require "\#{$root}/controllers/content"

        puts "\\tController: #{capitalizedName}"

        class #{controllerName} < ContentController
            
            set :content_dir, "\#{$root}/#{downcasedName}"
            set :stylesheet, "content"
            set :public_folder, $assets_root
            set :views, $views

        end
    CONTENT

    initialContent = "# #{capitalizedName}\n\nYour content goes here."

    cwd = Dir.pwd

    controllers = YAML.load_file("#{cwd}/controllerlist.yml")
    controllers.select! { |c| c["file"] != downcasedName }

    controllers << {
        "file" => downcasedName,
        "name" => controllerName,
        "path" => "/#{downcasedName}"
    }

    controllers.sort! { |a, b| a["file"] <=> b["file"] }

    content = YAML.load_file("#{cwd}/contentlist.yml")
    content.select! { |c| c != downcasedName }

    content << downcasedName

    content.sort!

    `echo '#{controllers.to_yaml}' > #{cwd}/controllerlist.yml`
    `echo '#{content.to_yaml}' > #{cwd}/contentlist.yml`
    `mkdir #{cwd}/#{downcasedName}`
    `echo '#{initialContent}' > #{cwd}/#{downcasedName}/#{downcasedName}.md`
    `echo '#{contentController}' > #{cwd}/controllers/#{downcasedName}.rb`
end
