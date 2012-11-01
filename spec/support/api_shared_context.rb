shared_context 'API context' do
  let(:json) { MultiJson.decode(last_response.body, symbolize_keys: true) }
end
