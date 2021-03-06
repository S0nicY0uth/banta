require 'rails_helper'

RSpec.describe Message, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:chat_room) }
  end

  describe 'relations' do
    it {should belong_to(:user)}
    it {should belong_to(:chat_room)}
  end

end
