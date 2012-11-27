module ActionController
  class Responder

    protected

    # Make respond_with return full_messages to reduce unnecessary error
    # handling logic in API client (iOS app)
    def json_resource_errors
      {errors: resource.errors.full_messages.uniq}
    end
  end
end
