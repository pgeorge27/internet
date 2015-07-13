<!-- 

var baseTime = 240;
var time;
var timeWait = 10000;
var control = false;
var urlBase = "/";
var timeoutMessage;
var title = "";
var timeoutID; 
var waitID;  
var __ExecutePleaseWait = false ;
var tiempo = 60 * 1000; //seconds
var speed = 50;   // decrease value to increase speed (must be positive)
var pause = 8000; // increase value to increase pausevar timerID = null
var bannerRunning = false;
var ar = new Array();
ar[0] = "Login : ";
var currentMessage = 0;
var offset = 0;

function getControlTime(){
 if (time == null){
   time = baseTime * 1000; // segundos
 }
 return time;
}

function iniciarConteo(){ 
   clearTimeout(timeoutID);  
   timeoutID = setTimeout("__ShowPleaseWait()" ,getControlTime());
}
function __exit(){
	clearTimeout(timeoutID);      
	timeoutID = setTimeout("tiempoCumplido()", tiempo);
}

function setTimer(){
    var docu = top.document;
    var ventanas = docu.frames;
	if (ventanas){
		if(ventanas.length >0){
			for (var i=0; i < ventanas.length;i++){
			   ventanaActual = ventanas[i];
			   ventanaActual.onscroll= iniciarConteo;
			   ventanaActual.document.onkeypress=iniciarConteo;
			   ventanaActual.document.onmousemove=iniciarConteo;
			   ventanaActual.document.onclick=iniciarConteo;
			}
		}
     }else{
           docu.onscroll=iniciarConteo;
           docu.onkeypress=iniciarConteo;
           docu.onmousemove=iniciarConteo;
           docu.onclick=iniciarConteo;
     }    
}
function setExitTimer(){
    var docu = top.document;
    var ventanas = docu.frames;
	if (ventanas){
		if(ventanas.length >0){
			for (var i=0; i < ventanas.length;i++){
			   ventanaActual = ventanas[i];
			   ventanaActual.onscroll= __foo;
			   ventanaActual.document.onkeypress=__foo;
			   ventanaActual.document.onmousemove=__foo;
			   ventanaActual.document.onclick=__foo;
			}
		}
     }else{
           docu.onscroll=__foo;
           docu.document.onkeypress=__foo;
           docu.document.onmousemove=__foo;
           docu.document.onclick=__foo;
     }    
}
function __foo(){
}
function tiempoCumplido(){
  if(document.URL.search("index")==-1)
    top.location.replace(urlBase);
}

// Inicia el conteo
setTimer();

function stopBanner() {
        if (bannerRunning)                
		clearTimeout(timerID);
        bannerRunning = false;
}

function startBanner() {        
	stopBanner();
    showBanner();
}

function showBanner() {
	var text = ar[currentMessage]
	if (offset < text.length) 
	 {
	   if (text.charAt(offset) == " ")
		  offset++;
	   var partialMessage = text.substring(0, offset + 1);
	   window.status = partialMessage;
	   offset++;
	   timerID = setTimeout("showBanner()", speed);
	   bannerRunning = true;
	 }
	else
	 {
		offset = 0;
		timerID = setTimeout("showBanner()", pause);
		bannerRunning = true;
	 }
}


function adicionarStatus(s){
  stopBanner();
  ar[0]+=s;
  startBanner();
}

function limpiarStatus(){
  stopBanner();
  startBanner();
}

function escribirStatus(s){
  window.status=s;
}

function __CloseWait(){
	var _PopupPaint=document.getElementById("__objPleaseWait");
    if (_PopupPaint) { 
		_PopupPaint.style.display = "none";
	}		
	showListBoxes();
	setTimer();
}
function __ShowPleaseWait() { 
	var _PopupPaint=document.getElementById("__objPleaseWait") 
	if (_PopupPaint){ 
			hideListBoxes();
			_PopupPaint.style.zIndex = +1000000 
			_PopupPaint.style.display = "" 
			_PopupPaint.style.top = (((document.body.offsetHeight) - _PopupPaint.offsetHeight) / 2) + ((document.body.scrollTop)?document.body.scrollTop:0)
			_PopupPaint.style.left = ((document.body.offsetWidth - _PopupPaint.offsetWidth) / 2)                 
			__ExecutePleaseWait = true 
	} 
	__exit();
	setExitTimer();
} 
//  -->