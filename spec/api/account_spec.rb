require 'spec_helper'

describe 'Account' do
  include_context 'API context'

  let(:user) { create(:user) }

  describe 'verify credentials' do
    context 'with correct credentials' do
      it 'should return the user object' do
        authorize user.email, user.password
        api :get, '/account/verify_credentials'
        expect(last_response.body).to eq(user.to_json)
      end
    end

    context 'with incorrect credentials' do
      it 'should return error message' do
        authorize 'username', 'incorrect password'
        api :get, '/account/verify_credentials'
        expect(json).to have_key(:error)
        expect(last_response.status).to eq(401)
      end
    end

    context 'without credentials' do
      it 'should return error message' do
        api :get, '/account/verify_credentials'
        expect(json).to have_key(:error)
        expect(last_response.status).to eq(401)
      end
    end
  end
end
