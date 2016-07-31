##
# Extenção da classe String com ferramentas para mask de CEP.
# Adiciona e remove a mask da própria instância de String +self+.
String.class_eval do

  ##
  # Remove a mask de +self+, se houver.
  def remove_cep_mask!
    return self unless include_cep_mask?
    self.gsub! '-', ''
  end

  ##
  # Adiciona mask para +self+, se não houver e for em formato válido.
  def add_cep_mask!
    return self if include_cep_mask?
    self.insert 5, '-'
  end

  ##
  # Verifica se há mask para CEP em +self+.
  def include_cep_mask?
    self.length == 9 && self.include?('-')
  end
end
