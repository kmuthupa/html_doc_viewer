# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
HtmlDocViewer::Application.initialize!

CONVERSION_SERVER = 'http://172.16.240.136:4567'
