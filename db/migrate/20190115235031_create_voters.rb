class CreateVoters < ActiveRecord::Migration[5.2]
  def change
    create_table :voters do |t|
      t.integer :identification
      t.boolean :voted
      t.references :election, foreign_key: true
      t.references :group, foreign_key: true
      t.references :code, foreign_key: true

      t.timestamps
    end
  end
end
