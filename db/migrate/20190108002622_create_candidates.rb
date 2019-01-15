class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :picture_url
      t.references :position, foreign_key: true
      t.references :election, foreign_key: true

      t.timestamps
    end
  end
end
