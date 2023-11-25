class CreateUserStamps < ActiveRecord::Migration[7.0]
  def change
    create_table :user_stamps do |t|
      t.references :users, foreign_key: { to_table: :users, on_delete: :cascade }
      t.references :art_pieces, foreign_key: { to_table: :art_pieces, on_delete: :cascade }
      t.timestamps
    end
  end
end
