class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :rating
      t.boolean :isTBR
      t.boolean :isReading
      t.boolean :isRead
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
