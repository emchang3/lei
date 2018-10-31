require "yaml"

def add_new(name)
    if name.nil? || name.length == 0
        puts "Invalid custom page name." and return
    end

    controllerName = "#{name}Controller"
    downcasedName = name.downcase

    contentController = <<~CONTENT
        require "\#{$root}/controllers/content"

        puts "\\tController: #{name}"

        class #{controllerName} < ContentController
            
            set :content_dir, "\#{$root}/#{downcasedName}"
            set :stylesheet, "content"
            set :public_folder, $assets_root
            set :views, $views

        end
    CONTENT

    cwd = Dir.pwd
    controllers = YAML.load_file("#{cwd}/controllerlist.yml")
    controllers.select! { |c| c["file"] != downcasedName }

    controllers << {
        "file" => downcasedName,
        "name" => controllerName,
        "path" => "/#{downcasedName}"
    }

    `echo '#{controllers.to_yaml}' > #{cwd}/controllerlist.yml`
    `mkdir #{cwd}/#{downcasedName}`
    `echo '# #{downcasedName}' > #{cwd}/#{downcasedName}/#{downcasedName}.md`
    `echo '#{contentController}' > #{cwd}/controllers/#{downcasedName}.rb`
end