# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LAPreso::Application.initialize!

Sass::Plugin.options[:always_update] = true