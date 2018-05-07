require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MessagesHelper. For example:
#
# describe MessagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MessagesHelper, type: :helper do
  describe '#format_time' do
    it "should output the right time" do
      time = Time.parse('2018-04-30T18:42:31.936787Z')
      msg = Message.new(created_at: time)
      expect(helper.format_time(msg)).to eq 'Mon 06:42'
    end
  end
end
