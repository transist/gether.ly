require 'spec_helper'

describe 'Pages' do
  describe 'Homepage' do
    it 'should show welcome message' do
      get '/'
      expect(last_response.body) == 'Welcome to gether.ly'
    end
  end
end
