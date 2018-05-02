require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:email) }
    end

    describe 'relations' do
        it {should have_many(:messages)}
        it {should have_many(:user_chat_rooms)}
        it {should have_many(:chat_rooms).through(:user_chat_rooms)}
    end

    describe "To support a paperclip attachment named avatar" do
        it {should have_db_column("avatar_file_name").of_type(:string)}
        it {should have_db_column("avatar_content_type").of_type(:string)}
        it {should have_db_column("avatar_file_size").of_type(:integer)}
    end
end