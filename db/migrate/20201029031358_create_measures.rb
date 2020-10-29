class CreateMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :measures do |t|
      t.string :codebase
      t.string :checksum
      t.string :heading
      t.text :body
      t.string :key
      t.string :name
      t.string :label

      t.timestamps
    end

    add_index :measures, :codebase
    add_index :measures, :checksum
    add_index :measures, :key
  end
end
