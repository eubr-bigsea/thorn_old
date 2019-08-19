# frozen_string_literal: true

module JsonapiErrors
  module Errors
    class Invalid < ::JsonapiErrors::Errors::StandardError
      def initialize(error)
        @code = 'invalid_request'
        @errors = error.record.errors
        @status = 422
        @title = 'Invalid request'
      end

      def serializable_hash
        errors.reduce([]) do |r, (att, msg)|
          r << {
            code:   code,
            detail: msg,
            source: { pointer: "/data/attributes/#{att}" },
            status: status,
            title:  title
          }
        end
      end

      private

      attr_reader :errors
    end
  end
end
