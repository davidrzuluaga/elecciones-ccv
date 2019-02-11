class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user
      t.string :password_digest
      t.string :role
      t.string :logincode

      t.timestamps
    end
  end
end
