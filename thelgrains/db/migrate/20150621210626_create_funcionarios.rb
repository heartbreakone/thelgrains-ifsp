class CreateFuncionarios < ActiveRecord::Migration
  def up
    create_table :funcionarios do |t|
      t.references :user, index: true, null: false
      t.string :nome, null: false
      t.date :nascimento
      t.string :sexo, limit: 1
      t.string :telefone
      t.string :celular
      t.string :cep, limit: 8
      t.string :endereco
      t.string :email

      t.timestamps null: false
    end
  end

  def down
    drop_table :funcionarios
  end
end
