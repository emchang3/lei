# Regexp

A Regexp holds a regular expression, used to match a pattern against strings. Regexps are created using the `/.../` and `%r{...}` literals, and by the `Regexp::new` constructor.

Regular expressions (regexps) are patterns which describe the contents of a string. They're used for testing whether a string contains a given pattern, or extracting the portions that match. They are created with the `/pat/` and `%r{pat}` literals or the `Regexp.new` constructor.