var getDataOrderCallback;

function getCaptorDimensions() {
  var captorDimensions = loadCaptorDimensionsFromCookie();
  if (typeof(captorDimensions[0]) == "undefined" || typeof(captorDimensions[1]) == "undefined") {
    captorDimensions = guessCaptorDimensions();
  }
  var cwidth = captorDimensions[0];
  var cheight = captorDimensions[1];
  var captorDimensions = [cwidth, cheight];
  return captorDimensions;
}

function guessCaptorDimensions() {
  var supp_screen_width={r800:"40",r1024:"50",r1152:"50",r1280:"60",r1366:"65",r1350:"65",r1920:"75"};
  var supp_screen_height={r600:"40",r768:"50",r864:"50",r800:"50",r720:"50",r960:"50",r1024:"50",r760:"50",r1080:"50"};
  var my_screen_key_width = "r"+screen.width;
  var my_screen_key_height = "r"+screen.height;
//  alert("Resolution: " + my_screen_key_width + "x" + my_screen_key_height);

  cwidth = supp_screen_width[my_screen_key_width];
  if (cwidth === undefined) {
    cwidth = 50;
  }
  cheight = supp_screen_height[my_screen_key_height];
  if (cheight === undefined) {
    cheight = 50;
  }

  var captorDimensions = [cwidth, cheight];
  return captorDimensions;
}

function saveCaptorDimensionsToCookie() {
  if (! SAVE_DIMENSIONS_TO_COOKIE) {
    return;
  }
  setGemaltoCookie("GEMALTO_CAPTOR_WIDTH", captorWidth, 365);
  setGemaltoCookie("GEMALTO_CAPTOR_HEIGHT", captorHeight, 365);
}

function loadCaptorDimensionsFromCookie() {
  if (! SAVE_DIMENSIONS_TO_COOKIE) {
    return;
  }
  var cwidth = getGemaltoCookie("GEMALTO_CAPTOR_WIDTH");
  var cheight = getGemaltoCookie("GEMALTO_CAPTOR_HEIGHT");
  var captorDimensions = [cwidth, cheight];
  return captorDimensions;
}

function setGemaltoCookie(c_name,value,exdays){
  var exdate=new Date();
  exdate.setDate(exdate.getDate() + exdays);
  var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
  document.cookie=c_name + "=" + c_value;
}

function getGemaltoCookie(c_name) {
  var i,x,y,ARRcookies=document.cookie.split(";");
  for (i=0;i<ARRcookies.length;i++)
    {
    x=ARRcookies[i].substr(0,ARRcookies[i].indexOf("="));
    y=ARRcookies[i].substr(ARRcookies[i].indexOf("=")+1);
    x=x.replace(/^\s+|\s+$/g,"");
    if (x==c_name)
      {
      return unescape(y);
      }
    }
}

function divResizeUp() {
  newCaptorWidth = parseInt(captorWidth);
  if (newCaptorWidth === undefined) {
    return
  }
  newCaptorWidth = (newCaptorWidth + 5);
  captorWidth = newCaptorWidth;
  saveCaptorDimensionsToCookie();
  executeOnLoad();
}

function divResizeDn() {
  newCaptorWidth = parseInt(captorWidth);
  if (newCaptorWidth === undefined) {
    return
  }
  newCaptorWidth = (newCaptorWidth - 5);
  if (newCaptorWidth < 0) {
    return
  }
  captorWidth = newCaptorWidth;
  saveCaptorDimensionsToCookie();
  executeOnLoad();
}

function clearTransmissionArea() {
  clearTimeout (iTimeoutID);
  var node = document.getElementById('captorsTransmissionZone');
  while (node.hasChildNodes()) {
    node.removeChild(node.firstChild);
  }
  captorsTransmissionZone=new Array();
}

function handleException(e) {
  // this function should be customized by the integrator
  alert("An error occured. Error: " + e);
}
