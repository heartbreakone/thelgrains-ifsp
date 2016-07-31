##
# Extenção da classe String com ferramentas para validação de dígito verificador de CPF.
# Valida os dígitos verificadores pelo método de Módulo 11 na instância de String +self+.
String.class_eval do

  ##
  # Valida os dígitos verificadores do CPF e o CPF.
  def validate_cpf
    return false unless self.length == 11
    self.cpf_first_digit && self.cpf_second_digit
  end

  protected

  ##
  # Valida por módulo 11 o primeiro dígito verificador.
  def cpf_first_digit
    digit = self[9] # separa o 1º digito verificador do cpf
    sum = 0
    for i in 0..8 # soma os digitos multiplicados por seu peso
      sum += self[i].to_i * (10 - i)
    end
    digit_check sum, self[9] # modulo 11
  end

  ##
  # Valida por módulo 11 o segundo dígito verificador.
  def cpf_second_digit
    digit = self[10] # separa o 1º digito verificador do cpf
    sum = 0
    for i in 0..9 # soma os digitos multiplicados por seu peso
      sum += self[i].to_i * (11 - i)
    end
    digit_check sum, self[10]
  end

  ##
  # Valida o dígito verificador com Módulo 11.
  # +sum+ soma com peso dos digitos.
  # +d+ dígito verificador.
  def digit_check(sum, d)
    mod = sum % 11
    return (d.to_i == 0) if mod < 2 # se for < 2 vira 0 e verifica
    d.to_i == 11 - mod # se nao subtrai de 11 e verifica
  end

end
