class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_foreign_key :blogs, :users
    add_index :blogs, [:user_id, :created_at]
  end
end
