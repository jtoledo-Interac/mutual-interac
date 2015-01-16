/**************************************************/
/*** REPOSITORIO DE FUNCIONES JAVASCRIPT/JQUERY ***/
/*** AUTOR				:	JIU				   	***/
/*** INTERAC LTDA.								***/
/*** FECHA CREACION		:	DIC 2013		   	***/
/**************************************************/	

//******************************************************************************
//Set de funciones que se ejecutan automaticas al cargar pagina
//******************************************************************************
$(function()
{
	setNumerico();
	setDatePicker();
	formatRut();
	formatNum();
});
//******************************************************************************
//Bloquea caracteres no numericos
//******************************************************************************
function setNumerico(){
	
	$('.numerico').keypress(function(e){ 
		  return numerico(e);
	});
	
	$('.numerico').blur(function(){ 
		  return numericoBlur(this);
	});
}
//******************************************************************************
//Llamada Ajax
//******************************************************************************
function ajaxCall(url, callback, msjError){

	$.ajax({
	  type: "POST",
	  url: url
	})
	.success(function(response){
		callback(response);
    })
	/*.done(function() {
		callback();
	})*/
	.fail(function(){
		jAlert(msjError);
	});
}
//******************************************************************************
//Bloquear Click Derecho
//******************************************************************************
function bloquearClickDerecho(){

	if(document.layers) 
		window.captureEvents(Event.MOUSEDOWN); 

	function bloquear(e){
		
		if (navigator.appName == 'Netscape' && (e.which == 2 || e.which == 3)) { 
			return false; 
		}
		
		if (navigator.appName == 'Microsoft Internet Explorer' && (event.button == 2 || event.button == 3)) {
			return false; 
		}
	} 
	
	window.onmousedown=bloquear; 
	document.onmousedown=bloquear;
}
//******************************************************************************
//Asigna el Datepicker
//******************************************************************************
function setDatePicker()
{
	$(".fecha").each(function(){
		var fecha = $(this);

		$(fecha).datepicker({ 
			dateFormat: 'dd/mm/yy',
			changeMonth: true,
			changeYear: true,
			yearRange: "1980:2014",
			defaultDate: new Date()
		});
	});
}
//******************************************************************************
//Valida que el campo sea solo numerico
//******************************************************************************
function numerico(evt)
{
    var retorno = true;
    var charCode = (evt.which) ? evt.which : event.keyCode;

    if (charCode > 31 && (charCode < 48 || charCode > 57))
		retorno = false;

    return retorno;
}
//******************************************************************************
//Valida que el campo sea solo numerico al perder el foco
//******************************************************************************
function numericoBlur(campo)
{
	var esNumerico = $(campo).val();
	
	if (!/^([0-9])*$/.test(esNumerico)){
		$(campo).val('');
		alert("Este campo acepta solo numeros");
		return false;
	}
}
//******************************************************************************
//Formatea el rut
//******************************************************************************
function formatRut()
{	
	$(".rut").each(function(){

		var sRut = this;
		var sDV = $(this).parent().find('#sDV');

		$(this).Rut({
			on_error: function(){
				alert('Rut incorrecto'); 
				$(sRut).val('');
				$(sDV).val('');
				$(sRut).focus();
			},
			on_success: function(){
				setDV(sRut, sDV);
			},
			format_on: 'keyup'
		});
	});
}

//******************************************************************************
//Asigna el Digito Verificador
//******************************************************************************
function setDV(sRut, sDV){
	$(sDV).val($(sRut).val().split('-')[1]);
}
//******************************************************************************
//Formateador de miles
//******************************************************************************
function formatNum(){
	$(".format").each(function(){
		$(this).blur(function(){
			$(this).val(formatNumero($(this).val()));
		});
	});
}

function formatNumero(numero){
	numero = (isNaN(numero))? "0" : Math.round(numero).toString();

	for (var i = 0; i < Math.floor((numero.length-(1+i))/3); i++)
		numero = numero.substring(0, numero.length - (4*i+3)) + '.' + numero.substring(numero.length-(4*i+3));

	return (numero);
}

function quitarPuntos(numero){
	
	return numero.replace('.','');
}