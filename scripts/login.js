/**
 * Funciones de login.jsp
 * @author Nazareth Omar Martinez Valerio
 */

/**
 * Cambia el tipo del input a Submit
 * 
 */
 document.oncontextmenu = function(){return false} 
function login() {
    document.acceder.submit();
}

/**
 * Valida que los caracteres sean Numeros
 * @param {type} e
 * @returns {Boolean}
 */


function validar(e) {
  tecla = (document.all) ? e.keyCode : e.which;
  return  !(tecla==86 && e.ctrlKey);
}