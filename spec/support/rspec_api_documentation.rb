require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.curl_host = 'http://localhost:3000'
  config.api_name = 'API Byebnk'
  config.api_explanation = 'API de desenvolvimento Byebnk'

  config.docs_dir = Rails.root.join('docs', 'blueprint')
  config.format = [:api_blueprint]
end
