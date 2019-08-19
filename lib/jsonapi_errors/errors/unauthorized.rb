# frozen_string_literal: true

module JsonapiErrors
  module Errors
    class Unauthorized < ::JsonapiErrors::Errors::StandardError
      def initialize(error)
        super(
          code:   error[:code] || 'unauthorized',
          detail: error[:message] || 'You need to login to authorize this request.',
          source: { pointer: '/request/headers/authorization' },
          status: 401,
          title:  'Unauthorized'
        )
      end
    end
  end
end
