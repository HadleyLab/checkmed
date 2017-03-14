class CreateExecutorRoles < ActiveRecord::Migration
  def change
    create_table :executor_roles do |t|
      t.string  :name,              null: false
      t.integer :prior, default: 9, null: false

      t.timestamps null: false
    end

    add_index :executor_roles, :prior
  end
end
