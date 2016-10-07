class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :founders
      t.string :headquarters
      t.string :category
      t.date :founded_at
      t.string :image

      t.timestamps
    end
  end
end
