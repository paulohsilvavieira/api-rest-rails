class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.references :user, foreign_key: true, index: true
      t.timestamps
    end
  end
end
