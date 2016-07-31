# Validação de CEP e afins
$ ->
  window.consultacep = (cep) ->
    cep = cep.replace /\D/g, ''
    if cep.length != 8
      $('#logradouro').val('').prop 'disabled', false
      $('#bairro').val('').prop 'disabled', false
      $('#localidade').val('').prop 'disabled', false
      $('#funcionario_endereco_estado').val(null).prop 'disabled', false
    else
      $.ajax
        dataType: 'jsonp'
        jsonp: 'correiocontrolcep'
        url: "http://cep.correiocontrol.com.br/#{cep}.js"

  window.correiocontrolcep = (valor) ->
    return alert 'Cep não encontrado!' if valor.erro
    $('#logradouro').val(valor.logradouro).prop 'disabled', true
    $('#bairro').val(valor.bairro).prop 'disabled', true
    $('#localidade').val(valor.localidade).prop 'disabled', true
    $('#funcionario_endereco_estado').val(valor.uf).prop 'disabled', true
