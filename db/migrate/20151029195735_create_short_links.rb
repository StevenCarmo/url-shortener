class CreateShortLinks < ActiveRecord::Migration
  def change
    create_table :short_links do |t|
      t.integer    :long_link_id,     null: false
      t.string     :slug,             null: false
      t.timestamps null: false
    end

    add_index :short_links, :long_link_id, unique: true
    add_index :short_links, :slug, unique: true
    add_foreign_key :short_links, :long_links, unique: true
  end
end
