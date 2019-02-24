class CreateAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :auths do |t|
      t.references :user, foreign_key: true
      t.string :sessioncode
      t.string :log

      t.timestamps
    end
  end
end
