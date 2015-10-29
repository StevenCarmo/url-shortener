class CreateLongLinks < ActiveRecord::Migration
  def change
    create_table :long_links do |t|
      t.string     :url,                null: false
      t.timestamps null: false
    end

    add_index :long_links, :url,        unique: true

  end
end
