require 'rails_helper'

RSpec.describe UserChatRoom, type: :model do
  describe 'relations' do
    it {should belong_to(:user)}
    it {should belong_to(:chat_room)}
  end
end
