require 'active_support/concern'

module Filterable
  extend ActiveSupport::Concern
  include JsonapiErrors

  OPERATORS = { gt: '>', gte: '>=', eq: '=', lte: '<=', lt: '<' }.freeze

  included do
    scope :filtered_by, lambda { |filter_query_stringify|
      filter_query = filter_query_stringify.deep_symbolize_keys
      fields = attribute_names.map(&:to_sym)
      operator = ''
      property, filter_options = filter_query.first

      unless fields.include?(property)
        raise Errors::StandardError,
              detail: "Invalid filter property #{property}",
              status: 422,
              title:  'Invalid Sort',
              code:   'invalid_filter_operator',
              source: { pointer: '/data/attributes/filtered_by' }

      end
      query_array = []
      filter_options.each do |filter_option|
        operator_key, value = filter_option
        operator = OPERATORS[operator_key]

        unless operator
          raise Errors::StandardError,
                detail: "Invalid filter operator #{operator_key}",
                status: 422,
                title:  'Invalid Filter',
                code:   'invalid_filter_operator',
                source: { pointer: '/data/attributes/filtered_by' }
        end

        query_array << "#{table_name}.#{property} #{operator} '#{value}'"
      end

      query = query_array.join(' AND ')

      return where(query)
    }

    def self.filterable_by(*fields)
      table_name = name.underscore.pluralize
      scope :filtered_by, lambda { |filter_query_stringify|
        filter_query = filter_query_stringify.deep_symbolize_keys
        operator = ''
        property, filter_options = filter_query.first

        unless fields.include?(property)
          raise Errors::StandardError,
                detail: "Invalid filter property #{property}",
                status: 422,
                title:  'Invalid Sort',
                code:   'invalid_sort_option',
                source: { pointer: '/data/attributes/sort_by' }

        end

        query = filter_options.map do |filter_option|
          operator_key, value = filter_option
          operator = OPERATORS[operator_key]

          unless operator
            raise Errors::StandardError,
                  detail: "Invalid filter operator #{operator_key}",
                  status: 422,
                  title:  'Invalid Filter',
                  code:   'invalid_filer_operator',
                  source: { pointer: '/data/attributes/filtered_by' }
          end

          "#{table_name}.#{property} #{operator} '#{value}'"
        end.join(' AND ')

        return where(query)
      }
    end
  end

  def self.property_error(property); end

  def self.operator_error(operator); end
end
