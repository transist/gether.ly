require 'spec_helper'

describe 'Signup' do
  include_context 'API context'

  context 'with valid profile' do
    it 'should return the newly created user object' do
      expect {
        user = {
          country_code: '+86',
          phone: '13917794404',
          email: 'rainux@gmail.com',
          name: 'Rainux',
          password: 'secret'
        }
        api :post, '/signup', user: user
        expect(json).to have_key(:email)
      }.to change(User, :count).by(1)
    end
  end

  context 'with invalid profile' do
    it 'should return errors' do
      expect {
        user = {
          country_code: '+86',
          phone: '13917794404',
          email: 'rainux@gmail.com',
          name: 'Rainux',
        }
        api :post, '/signup', user: user
        expect(json).to have_key(:errors)
      }.to_not change(User, :count)
    end
  end
end
