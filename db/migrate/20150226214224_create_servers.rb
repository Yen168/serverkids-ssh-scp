class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.string :host
      t.string :user
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
