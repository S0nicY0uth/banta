class ChangeColumnContentMessages < ActiveRecord::Migration[5.2]
  change_table :messages do |t|
    t.change :content, :text
  end
end
