class FoundationModels < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :technologies do |t|
      t.references :user, null: false, index: false
      t.string :name, null: false
      t.index [:user_id, :name], unique: true
    end

    create_table :categories do |t|
      t.references :user, null: false, index: false
      t.references :technology, null: false, index: false
      t.string :name, null: false
      t.index [:user_id, :technology_id], unique: true
      t.index [:user_id, :name], unique: true
    end

    create_table :repositories do |t|
      t.references :user, null: false, index: false
      t.references :category, null: false, index: false
      t.string :name, null: false
      t.jsonb :details
      t.index [:user_id, :name], unique: true
    end
  end
end
