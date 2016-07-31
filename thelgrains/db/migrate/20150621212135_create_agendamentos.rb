class CreateAgendamentos < ActiveRecord::Migration
  def up
    create_table :agendamentos do |t|
      t.references :user, index: true, null: false
      t.references :cliente, index: true
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :all_day

      t.timestamps null: false
    end
  end

  def down
    drop_table :agendamentos
  end
end
