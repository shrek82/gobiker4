class CreateEventSigns < ActiveRecord::Migration
  def change
    create_table :event_signs do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :num_people
      t.string :intro
      t.boolean :is_anonymous

      t.timestamps
    end
  end
end
