require 'rails_helper'

RSpec.describe ChatRoom, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'relations' do
    it {should have_many(:messages)}
    it {should have_many(:user_chat_rooms)}
    it {should have_many(:users).through(:user_chat_rooms)}
  end
end
