class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.date :start_date, default: ""
      t.date :end_date, default: ""
      t.text :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
