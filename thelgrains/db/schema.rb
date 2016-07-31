# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151026201600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agendamentos", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "cliente_id"
    t.string   "title"
    t.text     "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "all_day"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "agendamentos", ["cliente_id"], name: "index_agendamentos_on_cliente_id", using: :btree
  add_index "agendamentos", ["user_id"], name: "index_agendamentos_on_user_id", using: :btree

  create_table "ajudantes", force: :cascade do |t|
    t.integer  "atendimento_id", null: false
    t.integer  "user_id",        null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "ajudantes", ["atendimento_id"], name: "index_ajudantes_on_atendimento_id", using: :btree
  add_index "ajudantes", ["user_id"], name: "index_ajudantes_on_user_id", using: :btree

  create_table "atendimentos", force: :cascade do |t|
    t.integer  "servico_id",               null: false
    t.integer  "user_id",                  null: false
    t.integer  "cliente_id"
    t.decimal  "gasto_add",  default: 0.0
    t.string   "state"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.date     "data"
  end

  add_index "atendimentos", ["cliente_id"], name: "index_atendimentos_on_cliente_id", using: :btree
  add_index "atendimentos", ["servico_id"], name: "index_atendimentos_on_servico_id", using: :btree
  add_index "atendimentos", ["user_id"], name: "index_atendimentos_on_user_id", using: :btree

  create_table "categoria_servicos", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clientes", force: :cascade do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "celular"
    t.string   "email"
    t.string   "cpf",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "clientes", ["cpf"], name: "index_clientes_on_cpf", unique: true, using: :btree
  add_index "clientes", ["email"], name: "index_clientes_on_email", using: :btree

  create_table "entradas", force: :cascade do |t|
    t.integer  "atendimento_id"
    t.text     "descricao"
    t.integer  "tipo_pagamento"
    t.decimal  "valor"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "funcionarios", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.string   "nome",                 null: false
    t.date     "nascimento"
    t.string   "sexo",       limit: 1
    t.string   "telefone"
    t.string   "celular"
    t.string   "cep",        limit: 8
    t.string   "endereco"
    t.string   "email"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "funcionarios", ["user_id"], name: "index_funcionarios_on_user_id", using: :btree

  create_table "produtos", force: :cascade do |t|
    t.string   "nome"
    t.decimal  "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saidas", force: :cascade do |t|
    t.string   "nome"
    t.text     "descricao"
    t.decimal  "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servicos", force: :cascade do |t|
    t.integer  "categoria_servico_id", null: false
    t.string   "nome"
    t.decimal  "valor"
    t.decimal  "taxa"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "servicos", ["categoria_servico_id"], name: "index_servicos_on_categoria_servico_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "cpf",                limit: 11,                 null: false
    t.string   "encrypted_password",                            null: false
    t.boolean  "admin",                         default: false
    t.boolean  "active",                        default: true
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "users", ["cpf"], name: "index_users_on_cpf", unique: true, using: :btree

  create_table "web_comentarios", force: :cascade do |t|
    t.string   "nome",       null: false
    t.string   "email",      null: false
    t.text     "comentario"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "web_comentarios", ["email"], name: "index_web_comentarios_on_email", using: :btree

end
