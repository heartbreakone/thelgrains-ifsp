# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

f = Funcionario.new(nome: 'Pedro Gabriel', cep: '00000000',
                       endereco: 'Rua Pedro Vicente, 133, apto 130',
                       telefone: '1122223333')
f.build_user(cpf: '916.017.617-24', admin: false)
f.user.password = f.user.password_confirmation = 'senha123'
f.save

f2 = Funcionario.new(nome: 'Victor Zebini', cep: '00000000',
                        endereco: 'Rua Pedro Vicente, 133, apto 100',
                        telefone: '1133334444')
f2.build_user(cpf: '438.747.644-35', admin: true)
f2.user.password = f2.user.password_confirmation = 'senha123'
f2.save

f3 = Funcionario.new(nome: 'Rapahel Oliveira', cep: '00000000',
                        endereco: 'Rua Pedro Vicente, 133, apto 100',
                        telefone: '1133334444')
f3.build_user(cpf: '438.747.644-35', admin: true)
f3.user.password = f2.user.password_confirmation = 'senha123'
f3.save


c = Cliente.create(nome: 'Machado de Assis', telefone: '1155558888', cpf: '74010819030')

c2 = Cliente.create(nome: 'Arnold Schwarzenegger', telefone: '1155558888', cpf: '662.605.571-24')

cats = CategoriaServico.create([{ nome: 'Estética' }, { nome: 'Corte' }])

s = cats[1].servicos.create(nome: 'Corte Masculino Grande', valor: 10.0, taxa: 20.0)
s2 = cats[0].servicos.create(nome: 'Limpeza de Pele', valor: 10.0, taxa: 20.0)

Agendamento.create(user: f.user, title: "Corte de Cabelo Médio", cliente: c,
                     start_time: DateTime.now, end_time: DateTime.now + 2.hours)

Agendamento.create(user: f2.user, title: "Corte de Cabelo Médio",
                    start_time: DateTime.now + 1.hour, end_time: DateTime.now + 3.hours)

f2.user.agendamentos.create(title: "Progressiva", start_time: DateTime.now, cliente: c2,
                            end_time: DateTime.now + 5.hours + 25.minutes)

Atendimento.create(user: f.user, servico: s, cliente: c).ajudantes.create([{user: f2.user}, {user: f2.user}])
Atendimento.create(user: f2.user, servico: s2, cliente: c2)
