# frozen_string_literal: true

module JsonapiErrors
  class ErrorMapper
    @@mapped_errors = {}
    def self.mapped_errors
      @@mapped_errors
    end

    def self.map_errors!(errors_hash = {})
      @@mapped_errors.merge!(errors_hash)
    end

    def self.key_error?(error_klass)
      !mapped_errors[error_klass].nil?
    end

    def self.value_error?(error_klass)
      mapped_errors.value?(error_klass)
    end
  end
end
