module Paginate
  def paginate(data, serializer)
    render json: paginate_data(data, serializer)
  end

  def paginate_data(data, serializer)
    pagination = {
      page:     params[:page] || 1,
      per_page: params[:per_page] || Kaminari.config.default_per_page
    }

    collection = data.page(pagination[:page]).per(pagination[:per_page])

    pagination[:total_pages] = collection.total_pages
    pagination[:total_objects] = collection.total_count

    serializer.new(collection, meta: { pagination: pagination }).to_json
  end
end
