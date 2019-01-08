class CreateElections < ActiveRecord::Migration[5.2]
  def change
    create_table :elections do |t|
      t.date :year

      t.timestamps
    end
  end
end
