class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :email
      t.integer :role
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
