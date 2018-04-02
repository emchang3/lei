<<~load_css
    This function reads and returns the contents of a CSS file as a string. Its
    return value is assign to a variable for ease of interpolation in templates.
load_css

def load_css(filename)
    `cat #{$style_root}/#{filename}.css`
end