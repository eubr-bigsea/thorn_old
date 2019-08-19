# frozen_string_literal: true

module JsonapiErrors
  module Errors
    class ParameterMissing < ::JsonapiErrors::Errors::StandardError
      def initialize(error)
        super(
          code:   'parameter_missing',
          detail: error.message,
          source: { pointer: "/request/body/#{error.param}" },
          status: 422,
          title:  'Invalid request'
        )
      end
    end
  end
end
