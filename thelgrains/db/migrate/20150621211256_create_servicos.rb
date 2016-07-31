class CreateServicos < ActiveRecord::Migration
  def up
    create_table :servicos do |t|
      t.references :categoria_servico, index: true, null: false
      t.string :nome
      t.decimal :valor
      t.decimal :taxa

      t.timestamps null: false
    end
  end

  def down
    drop_table :servicos
  end
end
