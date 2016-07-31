# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  cpf                :string(11)       not null
#  encrypted_password :string           not null
#  admin              :boolean          default(FALSE)
#  active             :boolean          default(TRUE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid cpf' do
    u = User.new password: '12345678', password_confirmation: '12345678'
    assert_not u.valid?, 'valida nil cpf'
  end

  test 'valida non numerical cpf' do
    u = User.new password: '12345678', password_confirmation: '12345678'
    u.cpf = '123456teste'
    assert_not u.valid?
  end

  test 'valida cpf dif 11' do
    u = User.new password: '12345678', password_confirmation: '12345678'
    u.cpf = '138'
    assert_not u.valid?
  end

  test 'valida dig verificador errado' do
    u = User.new password: '12345678', password_confirmation: '12345678'
    u.cpf = '13872745560'
    assert_not u.valid?
  end

  test 'nao valida cpf formatado' do
    u = User.new password: '12345678', password_confirmation: '12345678'
    u.cpf = '138.727.468-63'
    assert u.valid?
  end

  test 'valid password' do
    u = User.new cpf: '13872746863'
    assert_not u.valid?, 'valida nil password'
  end

  test 'valida password < 8' do
    u = User.new cpf: '13872746863'
    u.password = u.password_confirmation = '1'
    assert_not u.valid?
  end

  test 'valida passwords diferentes' do
    u = User.new cpf: '13872746863'
    u.password, u.password_confirmation = '1234567a', '1234567b'
    assert_not u.valid?
  end

  test 'nao valida senhas validas' do
    u = User.new cpf: '13872746863'
    u.password = u.password_confirmation = 'senha123'
    assert u.save, "nao valida senhas validas #{u.inspect}"
  end
end
