require 'active_support/concern'

module SerializableOptions
  extend ActiveSupport::Concern

  included do
    def requested_serializer_options(resource_name = nil)
      resource_name ||= controller_name.singularize
      json = { fields: {} }
      json[:fields][resource_name] = params[:fields].map(&:to_sym) if params[:fields]
      json[:include] = params[:include].map(&:to_sym) if params[:include]
      json
    end
  end
end
