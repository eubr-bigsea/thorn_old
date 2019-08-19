# frozen_string_literal: true

module JsonapiErrors
  module Errors
  end
end

require 'jsonapi_errors/errors/standard_error'
require 'jsonapi_errors/errors/forbidden'
require 'jsonapi_errors/errors/invalid'
require 'jsonapi_errors/errors/not_found'
require 'jsonapi_errors/errors/unauthorized'
