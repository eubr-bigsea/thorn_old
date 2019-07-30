# frozen_string_literal: true

module JsonapiErrors
  module Errors
    class NotFound < ::JsonapiErrors::Errors::StandardError
      def initialize(error)
        if error.class != Hash
          message = I18n.t('errors.messages.model_not_found', model: error.model, id: error.id)
        else
          message ||= error[:message]
          code = error[:code]
          pointer = error[:pointer]
        end

        super(
          code:   code || 'not_found',
          detail: message || 'We could not find the object you were looking for.',
          source: { pointer: pointer || '/request/url/:id' },
          status: 404,
          title:  'Record not Found'
        )
      end
    end
  end
end
