##
# Extenção da classe String com ferramentas para mask de CPF.
# Adiciona e remove a mask da própria instância de String +self+.
String.class_eval do

  ##
  # Remove a mask de +self+ se houver.
  def remove_cpf_mask!
    return self unless include_cpf_mask?
    self.gsub! '-', ''
    self.gsub! '.', ''
  end

  ##
  # Adiciona mask para +self+ se não houver.
  def add_cpf_mask!
    return self if include_cpf_mask?
    self.insert 9, '-'
    self.insert 6, '.'
    self.insert 3, '.'
  end

  ##
  # Verifica se há mascara no CPF.
  def include_cpf_mask?
     self.include?('.') && self.include?('-') && self.length == 14
  end
end
