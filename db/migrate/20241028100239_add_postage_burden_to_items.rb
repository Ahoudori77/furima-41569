class AddPostageBurdenToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :postage_burden, :string
  end
end
