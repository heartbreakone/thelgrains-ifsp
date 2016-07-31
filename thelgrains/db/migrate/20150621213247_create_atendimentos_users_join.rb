class CreateAtendimentosUsersJoin < ActiveRecord::Migration
  def up
    create_table :ajudantes do |t|
      t.references :atendimento, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps null: false
    end
  end
  def down
    drop_table :ajudantes
  end
end
