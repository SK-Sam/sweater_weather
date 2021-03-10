require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password_digest }
    it { should validate_uniqueness_of :email }
  end
  describe 'Attributes' do
    it 'can instantiate with attributes' do
      email = 'test@test.com'
      password = 'password'
      user = User.create(email: email, password: password, password_confirmation: password)

      expect(user.email).to eq(email)
      expect(user.password).to be_a(String)
      expect(user.api_key).to be_a(String)
    end
  end
end
