class CreateTableProduto < ActiveRecord::Migration
  def up
    create_table :produtos do |t|
      t.string :nome
      t.decimal :valor

      t.timestamps null: false
    end
  end
  def down
    drop_table :produtos
  end
end
