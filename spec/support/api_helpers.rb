module ApiHelpers
  def api(verb, path, params = {})
    real_path = "/v1#{path}.json"
    send verb, real_path, params
  end
end

RSpec.configuration.include ApiHelpers, type: :request
