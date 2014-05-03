class AddAddressToTogethers < ActiveRecord::Migration
  def change
    add_column :togethers, :address, :string
  end
end
