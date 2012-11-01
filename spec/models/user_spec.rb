require 'spec_helper'

describe User do
  it 'should create instance via Factory' do
    expect {
      create(:user)
    }.to change(User, :count).by(1)
  end
end
