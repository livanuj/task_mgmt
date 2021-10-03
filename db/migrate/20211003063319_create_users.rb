class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, default: "", null: false, index: true
      t.string :password_digest, default: "", null: false

      t.timestamps
    end
  end
end
