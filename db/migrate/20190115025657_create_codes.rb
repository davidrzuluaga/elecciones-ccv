class CreateCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :codes do |t|
      t.string :code
      t.boolean :used

      t.timestamps
    end
  end
end
