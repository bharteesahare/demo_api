class AddCustomerAddressTable < ActiveRecord::Migration[7.0]

  def change
    # here we create the table for customers
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
    # here we create the table for addresses
    create_table :addresses do |t|
      t.references :customer, null: false
      t.string :street
      t.string :city
    end

  end

end
