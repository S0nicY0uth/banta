require 'rails_helper'

RSpec.describe "chat_rooms/index", type: :view do
  before(:each) do
    assign(:chat_rooms, [
      ChatRoom.create!(
        :name => "Name"
      ),
      ChatRoom.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of chat_rooms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
