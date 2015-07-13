
function formatear(){
  if (document.all["desc"])
    for (i=0; i<document.all["desc"].length; i++)
      formatDesc(document.all["desc"].item(i));
  }

function formatDesc(desc) {
  var Texto = desc.innerText;
  var re1 = /\s*[,]+\s*/g;
  var re2= /\s*[;]+\s*/g;
  var re3= /\s*[\\]+\s*/g;
  var re4= /\s*[\/]+\s*/g;
  var re5= /\s*[:]+\s*/g;
  if(Texto.search(re1) != -1){
    Texto = Texto.replace (re1, ", " );
  }
  if(Texto.search(re2) != -1){
    Texto = Texto.replace (re2,"; " );
  } 
  if(Texto.search(re3) != -1){
    Texto = Texto.replace (re3,"\ " );
  } 
  if(Texto.search(re4) != -1){
    Texto = Texto.replace (re4,"/ " );
  } 
  if(Texto.search(re5) != -1){
    Texto = Texto.replace (re5,": " );
  }
 
  desc.innerText= Texto;
}
