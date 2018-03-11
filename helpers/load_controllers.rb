def load_controllers
    puts "--- Loading Controllers ---"
    
    Dir.glob("#{$root}/controllers/*.rb") do |filename|
        require filename
    end
end