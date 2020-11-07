class FoundationModels < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :provider, null: false
      t.string :uid, null: false
    end

    create_table :technologies do |t|
      t.references :user, null: false, index: false
      t.string :name, null: false
      t.index [:user_id, :name], unique: true
    end

    create_table :categories do |t|
      t.references :technology, null: false, index: false
      t.string :name, null: false
      t.index [:technology_id, :name], unique: true
    end

    create_table :repositories do |t|
      t.references :category, null: false, index: false
      t.string :name, null: false
      t.jsonb :details, null: false, default: '{}'
      t.index [:category_id, :name], unique: true
    end
  end
end
