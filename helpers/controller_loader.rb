<<~load_controllers
    This function looks inside the controllers directory and requires all Ruby
    files found.
load_controllers

def load_controllers
    puts "--- Loading Controllers ---"
    
    Dir.glob("#{$root}/controllers/*.rb") do |filename|
        require filename
    end
end