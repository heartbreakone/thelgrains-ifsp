class AddDateAtendimento < ActiveRecord::Migration
  def up
    add_column :atendimentos, :data, :date
  end

  def down
    remove_column :atendimento, :data
  end
end
