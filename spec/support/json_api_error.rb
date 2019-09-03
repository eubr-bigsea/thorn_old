def json_api_errors(errors)
  {
    errors: errors.map do |e|
      {
        code:   e[:code],
        detail: e[:detail],
        source: e[:source],
        status: e[:status],
        title:  e[:title],
      }
    end
  }.to_json
end
