class CreateAdminSaidas < ActiveRecord::Migration
  def up
    create_table :entradas do |t|
      t.references :atendimento
      t.text :descricao
      t.integer :tipo_pagamento
      t.decimal :valor

      t.timestamps null: false
    end
    create_table :saidas do |t|
      t.string :nome
      t.text :descricao
      t.decimal :valor

      t.timestamps null: false
    end
  end
  def down
    drop_table :entradas
    drop_table :saidas
  end
end
