class CreateAsks < ActiveRecord::Migration
  def change
    create_table :asks do |t|
      t.string :title, :limit => 200
      t.string :intro
      t.integer :province_id
      t.string :city_integer
      t.string :tags, :limit => 50
      t.integer :user_id
      t.integer :hits_num
      t.integer :answers_num
      t.integer :useful_num
      t.integer :base_answer_id
      t.boolean :is_resolved
      t.boolean :is_recommended
      t.boolean :is_fixed

      t.timestamps
    end
  end
end
