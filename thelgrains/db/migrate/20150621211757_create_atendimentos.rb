class CreateAtendimentos < ActiveRecord::Migration
  def up
    create_table :atendimentos do |t|
      t.references :servico, index: true, null: false
      t.references :user, index: true, null: false
      t.references :cliente, index: true
      t.decimal :gasto_add, default: 0.0
      t.string :state

      t.timestamps null: false
  end

  def down
    drop_table :atendimentos
  end
end
