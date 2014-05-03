class CreateTogethers < ActiveRecord::Migration
  def change
    create_table :togethers do |t|
      t.integer :topic_id
      t.datetime :sign_start_at
      t.datetime :sign_finish_at
      t.datetime :start_at
      t.datetime :finish_at
      t.integer :sign_limit
      t.boolean :is_closed
      t.text :content

      t.timestamps
    end
    add_index :togethers, :topic_id
  end
end
