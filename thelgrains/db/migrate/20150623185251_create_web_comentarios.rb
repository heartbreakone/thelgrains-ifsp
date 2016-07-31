class CreateWebComentarios < ActiveRecord::Migration
  def change
    create_table :web_comentarios do |t|
      t.string :nome, null: false
      t.string :email, null: false, index: true
      t.text :comentario

      t.timestamps null: false
    end
  end
end
