class JsonApiResponder < ActionController::Responder
  def to_json(_obj = nil)
    if resource.class == Hash
      render json: resource
    else
      class_name =  case resource
                    when ActiveRecord::Relation
                      resource.first.class.name
                    when NilClass
                      'User'
                    else
                      resource.class.name
                    end

      serializer = (class_name + 'Serializer').constantize

      if has_errors?
        render json: { errors: resource.errors }, status: :unprocessable_entity
      else
        render json: serializer.new(resource)
      end
    end
  end
end
