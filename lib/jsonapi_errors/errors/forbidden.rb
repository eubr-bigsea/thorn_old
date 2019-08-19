# frozen_string_literal: true

module JsonapiErrors
  module Errors
    class Forbidden < ::JsonapiErrors::Errors::StandardError
      def initialize(error)
        super(
          code:   'forbidden',
          detail: error.message || 'You have no rights to access this resource',
          source: { pointer: '/request/headers/authorization' },
          status: 403,
          title:  'Forbidden request'
        )
      end
    end
  end
end
