class CreateMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :measures do |t|
      t.text :body
      t.string :hash
      t.string :heading
      t.string :key
      t.string :name
      t.string :label
      t.string :codebase

      t.timestamps
    end
    add_index :measures, :codebase
    add_index :measures, :hash
    add_index :measures, :key
  end
end
