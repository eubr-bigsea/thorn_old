require 'active_support/concern'

module Searchable
  extend ActiveSupport::Concern

  included do
    scope :search_by, lambda { |query|
      model_name = name.underscore.pluralize
      fields = columns_hash.reject { |att, v| att.include?('id') || v.type == :datetime }.map { |att, _v| att.to_sym }

      return nil if query.blank?

      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)
      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map do |e|
        (e.tr('*', '%') + '%').gsub(/%+/, '%')
      end
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conditions = fields.length
      where(
        terms.map do
          or_clauses = fields.map { |field| "#{model_name}.#{field} ILIKE ?" }.join(' OR ')
          "(#{or_clauses})"
        end.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
      )
    }

    def self.searchable_by(*fields)
      scope :search_by, lambda { |query|
        model_name = name.underscore.pluralize

        return nil if query.blank?

        # condition query, parse into individual keywords
        terms = query.downcase.split(/\s+/)
        # replace "*" with "%" for wildcard searches,
        # append '%', remove duplicate '%'s
        terms = terms.map do |e|
          (e.tr('*', '%') + '%').gsub(/%+/, '%')
        end
        # configure number of OR conditions for provision
        # of interpolation arguments. Adjust this if you
        # change the number of OR conditions.
        num_or_conditions = fields.length
        where(
          terms.map do
            or_clauses = fields.map { |field| "#{model_name}.#{field} LIKE ?" }.join(' OR ')
            "(#{or_clauses})"
          end.join(' AND '),
          *terms.map { |e| [e] * num_or_conditions }.flatten
        )
      }
    end
  end
end
