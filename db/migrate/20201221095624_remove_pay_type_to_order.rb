class RemovePayTypeToOrder < ActiveRecord::Migration
  def up
    remove_column :orders, :pay_type
  end

  def down
    add_column :orders, :pay_type, :string
  end
end
