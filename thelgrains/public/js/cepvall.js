/* Validação de CEP e afins */
    function consultacep(cep){

      cep = cep.replace(/\D/g,"")

      url="http://cep.correiocontrol.com.br/"+cep+".js"

      s=document.createElement('script')

      s.setAttribute('charset','utf-8')
   s.src=url
    document.querySelector('head').appendChild(s)
  }

    function correiocontrolcep(valor){

      if (valor.erro) {

        alert('Cep não encontrado');       

        return;

      };

      document.getElementById('logradouro').value=valor.logradouro

      document.getElementById('bairro').value=valor.bairro

      document.getElementById('localidade').value=valor.localidade

      document.getElementById('uf').value=valor.uf

    }




//-----------------------------------------------------------------
// Entrada DD/MM/AAAA
//-----------------------------------------------------------------
function fctValidaData(obj)
{
    var data = obj.value;
    var dia = data.substring(0,2)
    var mes = data.substring(3,5)
    var ano = data.substring(6,10)
 
    //Criando um objeto Date usando os valores ano, mes e dia.
    var novaData = new Date(ano,(mes-1),dia);
 
    var mesmoDia = parseInt(dia,10) == parseInt(novaData.getDate());
    var mesmoMes = parseInt(mes,10) == parseInt(novaData.getMonth())+1;
    var mesmoAno = parseInt(ano) == parseInt(novaData.getFullYear());
 
    if (!((mesmoDia) && (mesmoMes) && (mesmoAno)))
    {
        alert('Data informada é inválida!');   
        obj.focus();    
        return false;
    }  
    return true;
}