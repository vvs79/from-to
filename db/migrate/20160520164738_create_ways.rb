class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways do |t|
      t.string :from
      t.string :to

      t.timestamps null: false
    end
  end
end
