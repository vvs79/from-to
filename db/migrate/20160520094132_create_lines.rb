class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :line
      t.integer :kilometers
      t.integer :minutes

      t.timestamps null: false
    end
  end
end
