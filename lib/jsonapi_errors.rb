# frozen_string_literal: true

require 'jsonapi_errors/errors'
require 'jsonapi_errors/error_mapper'
require 'jsonapi_errors/error_serializer'

module JsonapiErrors
  def self.included(base)
    base.class_eval do
      ErrorMapper.map_errors!(
        'JsonapiErrors::Errors::Invalid' => 'JsonapiErrors::Errors::Invalid',
        'JsonapiErrors::Errors::Forbidden' => 'JsonapiErrors::Errors::Forbidden',
        'JsonapiErrors::Errors::NotFound' => 'JsonapiErrors::Errors::NotFound',
        'JsonapiErrors::Errors::Unauthorized' => 'JsonapiErrors::Errors::Unauthorized',
        'JsonapiErrors::Errors::StandardError' => 'JsonapiErrors::Errors::StandardError',
        'ActiveRecord::RecordNotFound' => 'JsonapiErrors::Errors::NotFound',
        'ActiveRecord::RecordInvalid' => 'JsonapiErrors::Errors::Invalid',
        'ActionController::ParameterMissing' => 'JsonapiErrors::Errors::ParameterMissing'
      )
    end
  end

  def handle_error(error)
    mapped = map_error(error)
    log_error(error) if respond_to?(:log_error) && !mapped
    render_error(mapped)
  end

  def map_error(error)
    error_klass = error.class.name

    return error if ErrorMapper.value_error?(error_klass)
    return Object.const_get(ErrorMapper.mapped_errors[error_klass]).new error if ErrorMapper.key_error?(error_klass)

    ::JsonapiErrors::Errors::StandardError.new
  end

  def render_error(error)
    render json: ::JsonapiErrors::ErrorSerializer.new(error), status: error.status
  end
end

JE = JsonapiErrors
JE::E = JsonapiErrors::Errors
JE::Invalid = JsonapiErrors::Errors::Invalid
JE::Forbidden = JsonapiErrors::Errors::Forbidden
JE::NotFound = JsonapiErrors::Errors::NotFound
JE::Unauthorized = JsonapiErrors::Errors::Unauthorized
