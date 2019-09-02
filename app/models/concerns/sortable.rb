require 'active_support/concern'

module Sortable
  extend ActiveSupport::Concern
  include JsonapiErrors

  included do
    scope :sorted_by, lambda { |sort_option|
      sort_option_sym = JSON.parse(sort_option).deep_symbolize_keys
      fields = attribute_names.map(&:to_sym)
      key = sort_option_sym.keys.first
      key = :first_name if key == :full_name
      direction = 'desc'

      value = sort_option_sym.values.first
      if value.instance_of? String
        direction = value.casecmp('desc').zero? ? 'desc' : 'asc'
      end

      return order(arel_table[key].send(direction)) if fields.include?(key)

      relations = {}

      attribute_names.select { |att| att.include?('_id') }.map do |r|
        relation_name = r.gsub('_id', '')
        relation_attributes = relation_name.classify.constantize.attribute_names.map(&:to_sym)
        relations[relation_name.to_sym] = relation_attributes
      end

      relation, relation_key = key.to_s.split('.').map(&:to_sym)

      if relations[relation] && relations[relation].include?(relation_key)
        relation_table = relation.to_s.classify.constantize.arel_table
        return model.joins(relation).order(relation_table[relation_key].send(direction))
      end

      raise Errors::StandardError,
            detail: "Invalid sort option: #{sort_option.to_json}",
            status: 422,
            title:  'Invalid Sort',
            code:   'invalid_sort_option',
            source: { pointer: '/data/attributes/sort_by' }
    }

    def self.sortable_by(*fields, relations: nil)
      scope :sorted_by, lambda { |sort_option|
        sort_option_sym = sort_option.deep_symbolize_keys
        key = sort_option_sym.keys.first
        direction = 'desc'

        value = sort_option_sym.values.first
        if value.instance_of? String
          direction = value.casecmp('desc').zero? ? 'desc' : 'asc'
        end

        return order(arel_table[key].send(direction)) if fields.include?(key)

        relation, relation_key = key.to_s.split('.').map(&:to_sym)

        if relations[relation] && relations[relation].include?(relation_key)
          relation_table = relation.to_s.classify.constantize.arel_table
          return model.joins(relation).order(relation_table[relation_key].send(direction))
        end

        raise Errors::StandardError,
              detail: "Invalid sort option: #{sort_option.to_json}",
              status: 422,
              title:  'Invalid Sort',
              code:   'invalid_sort_option',
              source: { pointer: '/data/attributes/sort_by' }
      }
    end
  end
end
