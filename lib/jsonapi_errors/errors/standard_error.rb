# frozen_string_literal: true

require 'jsonapi_errors/keys_stringifier'

module JsonapiErrors
  module Errors
    class StandardError < ::StandardError
      def initialize(code: nil, detail: nil, source: {}, status: nil, title: nil)
        @code = code || 'internal_server_error'
        @detail = detail
        @detail ||= I18n.t('errors.messages.server_error')
        @source = KeysStringifier.call(source)
        @status = status || 500
        @title = title || 'Something went wrong'
      end

      def serializable_hash
        [
          {
            code:   code,
            detail: detail,
            source: source,
            status: status,
            title:  title
          }
        ]
      end

      def to_h
        serializable_hash
      end

      def to_s
        serializable_hash.to_s
      end

      attr_reader :code, :detail, :source, :status, :title
    end
  end
end
