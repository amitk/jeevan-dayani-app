require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

# RspecApiDocumentation.configure do |config|
#   config.format = :json
# end

RspecApiDocumentation.configure do |config|
  config.format = :html
  config.request_body_formatter = :json
end
