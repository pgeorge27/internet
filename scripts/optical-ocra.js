//(c) Copyright 2011 Gemalto, Inc. All rights reserved.
/**
* @fileOverview This file contains the functions required for the optical reader software package (GUI, transmission)
* @author Gemalto
* @version 2.0
*/

//----------- Constants ----------

//Dimension of the transmission window (default)
var CONST_W=300;
var CONST_H=470;

//Link of the transmission window
var TRANSMIT_LINK_JAVASCRIPT="./wJavascript-ocra.htm";

//Name of the cookie used to store the window dimension
var COOKIE_W="opticalTransmissionWidth";
var COOKIE_H="opticalTransmissionHeight";

//Number of months for cookie to expire
var COOKIE_EXP=12;

//Captor size in the window
var CAPTOR_H=60;
var CAPTOR_W=120;

//Transmission characteristics

//Number of captors
var NB_CAPTOR=5;

//1st index after synchro frame
var SYNCHRO_INDEX=5; //same as NB_CAPTORS

//1ast index after last data bit
var END_INDEX=0;

//----------- Global variables ----------

//Dimension of the transmission window
var iWidth=CONST_W;
var iHeight=CONST_H;

//Transmission characteristics
var captorsNumber=NB_CAPTOR;
var synchCaptor=0;              //use by the UI transmission window
var captorWidth=CAPTOR_W;       //width of captor zone
var captorHeight=CAPTOR_H;      //height of captor zone
var zeroColor="white";          //color of a "zero" bit
var oneColor="black";           //color of a "one" bit
var borderSize=0;               //size ofthe border araound captors
var borderColor=zeroColor;

//Protocol characteristics: init sequences and time delays associated
var iShiftClockDelay = 20;      // delay before transmitting clock
var iDataDelay  = 20; //time clock stable during data bit(s) transmission - this is the half period

//Index of the clock optical captor (0 = first captor on the left)
var iClock = 0;

//Data transmission indexes
var iDataIdx = 0;

//Specific buffer for OCRA variables
var sStartCode = "";
var sCurrency = "";
var sTransactionAmount = "";
var sAccountNumber = "";
var sFromAccountNumber = "";
var sBenificiaryName = "";
var sToAccountNumber = "";
var sQuantity = "";
var sReference = "";
var sFolio = "";
var sChallenge = "";

//Buffer used to create and store the bits sequence to transmit
var sData="";
var aData;

//Clock starting value
var sClock="";

//internal
var captorsTransmissionZone = new Array();
var captorsTransmissionZoneStyle = new Array();
var Background;

var iTimeoutID = 0;

/*============================================================================
    Functions
============================================================================*/

//---------- Cookie management ----------

/**
* @function setCookie
* @description Create or update a cookie
* @param _sname Cookie name
* @param _svalue Cookie value
* @param _inbmonths Nb of months before the cookie expires
*/
function setCookie(_sname,_svalue,_inbmonths)
{
	if ( _sname == null || _sname == "" ) { 
		return;
	} else {
		var d_date = new Date();

		d_date.setMonth(d_date.getMonth()+_inbmonths);
		document.cookie = _sname + "=" + escape(_svalue) + ((_inbmonths == null) ? "" : ";expires=" + d_date.toUTCString()) + ";path=/"; // path? why?
	}
}

/**
* @function getCookie
* @description Get the value stored in a cookie
* @param _sname Cookie name
* @returns String containing the value stored in the cookie, empty string otherwise
*/
function getCookie(_sname)
{
    var i_start,i_end;

	if ( _sname == null || _sname == "" ) {
		return "";
	}
	
    if ( document.cookie.length>0 )
    {
         i_start=document.cookie.indexOf(_sname + "=");
         if (i_start!=-1)
         {
                i_start=i_start + _sname.length+1;
                i_end=document.cookie.indexOf(";",i_start);
                if (i_end==-1)
                {
                    i_end=document.cookie.length;
                }
                return unescape(document.cookie.substring(i_start,i_end));
         } //i_start!=-1
    } //document.cookie.length>0
    return "";
}

/**
* @function saveWindowsSize
* @description Save the window size in the cookie
*/
function saveWindowSize()
{
    if (iWidth== 0)
    {
        iWidth = CONST_W;
    }
    if(iHeight== 0)
    {
        iHeight = CONST_H;
    }
    setCookie(COOKIE_W,iWidth,COOKIE_EXP);
    setCookie(COOKIE_H,iHeight,COOKIE_EXP);
}

/**
* @function getWindowSize
* @description Get the window size from the cookie if existing, else get the default size
*/
function getWindowSize()
{
    if (getCookie(COOKIE_W)== "" || getCookie(COOKIE_W)== null)
    {
        iWidth = CONST_W;
    }
    else
    {
        iWidth = Number(getCookie(COOKIE_W));
    }
    if(getCookie(COOKIE_H)== "" || getCookie(COOKIE_H)== null)
    {
        iHeight = CONST_H;
    }
    else
    {
        iHeight = Number(getCookie(COOKIE_H));
    }
}

/**
* @function getWindowsSize2
* @description Get the size of the current window and set the global variables
*/
function getWindowSize2()
{
      iWidth = CONST_W;
      iHeight = CONST_H;

//    if( typeof( window.innerWidth ) == 'number' )
//    {
//        //Non-IE
//        iWidth = window.innerWidth;
//        iHeight = window.innerHeight;
//    }
//    else if (document.documentElement &&
//             (document.documentElement.clientWidth || document.documentElement.clientHeight))
//    {
//        //IE 6+ in 'standards compliant mode'
//        iWidth = document.documentElement.clientWidth;
//        iHeight = document.documentElement.clientHeight;
//    }
//    else if (document.body &&
//             (document.body.clientWidth || document.body.clientHeight))
//    {
//        //IE 4 compatible
//        iWidth = document.body.clientWidth;
//        iHeight = document.body.clientHeight;
//    }
}


/**
* @function openwJavascript
* @description Open a popup window for optical transmission using javascript with the default or stored size(cookie).
*/
function openwJavascript()
{
    getWindowSize();
    wTransmissionWindow = window.open(TRANSMIT_LINK_JAVASCRIPT,
                                    "wOpticalTransmission",
                                    "width="+iWidth+",height="+iHeight+",resizable=1");
}

//---------- User Interface ----------

/**
* @function initializeTransmissionArea
* @description Create transmission zone according to provided characteristics
* @param _nbofcaptors number of captors including possible synchro captor
* @param x                  absolute x coordinate of transmission zone
* @param y                  absolute y coordinate of transmission zone
* @param _bordersize         size of the border around captors
* @param _captorwidth        width of captor zone
* @param _captorheight       height of captor zone
* @param _zerobitcolor       color of a "zero" bit
* @param _onebitcolor        color of a "one" bit
* @param _backgroundcolor    color of the background
*/
function initializeTransmissionArea(
    _nbofcaptors,
    x,
    y,
    _bordersize,
    _captorwidth,
    _captorheight,
    _zerobitcolor,
    _onebitcolor,
    _backgroundcolor
)
{
    if (captorsTransmissionZone.length>0)
    {
        for (i=0;i<captorsTransmissionZone.length;i++)
        {
            document.body.removeChild(captorsTransmissionZone[i]) ;
        }
        document.body.removeChild(Background) ;
        captorsTransmissionZone=new Array();
    }

    numberOfCaptors  = _nbofcaptors;
    borderSize       = _bordersize;
    captorWidth      = _captorwidth;
    captorHeight      = _captorheight;
    zeroColor        = _zerobitcolor;
    oneColor         = _onebitcolor  ;


    Background = rectangle((x-_bordersize),
                         (y-_bordersize),
                         (_bordersize+(captorWidth+_bordersize)*numberOfCaptors),
                         (captorHeight+_bordersize+_bordersize),
                         _backgroundcolor,
                         _backgroundcolor);

    document.body.appendChild(Background) ;

    for ( i=0;i<numberOfCaptors;i++)
    {
        captorsTransmissionZone[i] = rectangle((x+(captorWidth+_bordersize)*i),
                                               y,captorWidth,captorHeight,
                                               oneColor,oneColor);

        document.body.appendChild(captorsTransmissionZone[i]) ;

        captorsTransmissionZoneStyle[i] = captorsTransmissionZone[i].style;
    }
}

/**
* @function rectangle
* @description Create a rectangle div
* @param _x x coordinate
* @param _y y coordinate
* @param _w width
* @param _h height
* @param _bg background color
* @param _bcol border color
* @returns rectangle
*/
function rectangle(_x,_y,_w,_h,_bg,_bcol)
{
    var rect=document.createElement("div");
    var style=rect.style;

    style.width=_w +"px";
    style.height=_h +"px";
    style.left=_x +"px";
    style.top=_y +"px";
    style.backgroundColor=_bg;
    style.borderColor= _bcol;    // fixed
    style.position="absolute";
    style.borderStyle="solid"
    style.borderWidth=1;
    style.fontFamily="Arial";
    style.fontSize="18px";
    style.textAlign="center";
    rect.innerHTML="";

    return rect;
}

/**
* @function createTransmissionArea
* @description Creation of optical transmission area and data encoding for tranmission
* @exception com.gemalto.opticalreader.exception
*/
function createTransmissionArea()
{
	try {
		//First get and save the size of the current window
		getWindowSize2();
		saveWindowSize();

		captorWidth = Math.round((iWidth)/captorsNumber);
		initializeTransmissionArea(captorsNumber,
									560,200,borderSize,captorWidth,
									captorHeight,zeroColor,oneColor,borderColor);

		var ocraEncoder = new com.gemalto.opticalreader.encoding.ocra();

		var dataDisplayOrder;
		if ( getDataOrderCallback != null ) {
			dataDisplayOrder = getDataOrderCallback();
		} else {
			dataDisplayOrder = [    com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CURRENCY,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TRANSACTION_AMOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_ACCOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FROM_ACCOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_BENIFICIARY_NAME,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TO_ACCOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_QUANTITY,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_REFERENCE,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FOLIO,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CHALLENGE
								];
		}

		var tempDataArray = ocraEncoder.buildTlvAndChallenge( dataDisplayOrder, sStartCode, sCurrency, sTransactionAmount, sAccountNumber, sFromAccountNumber, sBenificiaryName, sToAccountNumber, sQuantity, sReference, sFolio, sChallenge);

		sData = ocraEncoder.lowLevelEncoding( tempDataArray[0] );
		aData = convertToArrayOfNibble( tempDataArray[0] );
		setChallengeCallback( tempDataArray[1] );

		updateData();
	} catch (e) {
		throw e;
	}
}

/**
* @function convertToArrayOfNibble
* @description Convert a string of hexadecimal values to an array where each element represents a nibble to the hexadecimal string
*/
function convertToArrayOfNibble ( hexStr ) {
	var nibblesArray = new Array();

    for ( var i=0; i<hexStr.length; i++) {
		nibblesArray[i] = parseInt( hexStr.charAt(i), 16 );
	}

	return nibblesArray;
}
	
/**
* @function resizeTransmissionArea
* @description Resize of optical transmission area during transmission
*/
function resizeTransmissionArea() {
    //First get and save the size of the current window
    getWindowSize2();
    saveWindowSize();

    captorWidth = Math.round((iWidth) / captorsNumber);
    initializeTransmissionArea(captorsNumber,
                                0, 65, borderSize, captorWidth,
                                captorHeight, zeroColor, oneColor, borderColor);
}

/**
* @function resizeTransmissionArea2
* @description Resize of optical transmission area during transmission
*/
function resizeTransmissionArea2(iBigger) {
    var iLocalW = 0;
    var iLocalH = 0;

    //First get the size of the current transmission area
    getWindowSize();
//window.alert("iWidth Valor Original: " + iWidth);
//window.alert("iHeight Valor Original: " + iHeight);
    iLocalW = iWidth + iBigger;
    
    iWidth = iLocalW;
    saveWindowSize();

//window.alert("iWidth Nuevo Valor: " + iWidth);
//window.alert("iHeight Nuevo Valor: " + iHeight);

    captorWidth = Math.round((iWidth) / captorsNumber);
    initializeTransmissionArea(captorsNumber,
                                560,200, borderSize, captorWidth,
                                captorHeight, zeroColor, oneColor, borderColor);
}

/**
* @function biggerButton
* @description Resize the window
* @param iBigger Amount to increase/decrease the window size
*/
function biggerButton(iBigger) {
    var iLocalW = 0;
    var iLocalH = 0;
    getWindowSize2();

    iLocalW = iBigger;
    iLocalH = parseInt(100 + (iHeight - 100) * ((iWidth + iBigger) / iWidth) - iHeight);

    return window.resizeBy(iLocalW,iLocalH);
}

//---------- Data Transmission ----------
var clock_bit_color ="";

/**
* @function updateData
* @description Update the transmission area with the next data to be displayed and call updateClock to update the clock
*/    
function updateData() //trDataNew
{
	var DATA_TO_DISPLAY_LOOKUP = new Array();
	DATA_TO_DISPLAY_LOOKUP[0]  = [zeroColor, zeroColor ,zeroColor, zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[1]  = [zeroColor, zeroColor, zeroColor, oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[2]  = [zeroColor, zeroColor, oneColor,  zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[3]  = [zeroColor, zeroColor, oneColor,  oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[4]  = [zeroColor, oneColor,  zeroColor, zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[5]  = [zeroColor, oneColor,  zeroColor, oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[6]  = [zeroColor, oneColor,  oneColor,  zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[7]  = [zeroColor, oneColor,  oneColor,  oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[8]  = [oneColor,  zeroColor, zeroColor, zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[9]  = [oneColor,  zeroColor, zeroColor, oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[10] = [oneColor,  zeroColor, oneColor,  zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[11] = [oneColor,  zeroColor, oneColor,  oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[12] = [oneColor,  oneColor,  zeroColor, zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[13] = [oneColor,  oneColor,  zeroColor, oneColor  ];
	DATA_TO_DISPLAY_LOOKUP[14] = [oneColor,  oneColor,  oneColor,  zeroColor ];
	DATA_TO_DISPLAY_LOOKUP[15] = [oneColor,  oneColor,  oneColor,  oneColor  ];

	//update each sensor rectangle
	for ( var i=1; i<captorsNumber; i++ ) {
		var colorToDisplay = DATA_TO_DISPLAY_LOOKUP[ aData[iDataIdx] ][i - 1];

		if ( colorToDisplay == oneColor) {
			captorsTransmissionZoneStyle[i].visibility = 'visible';
		} else {
			captorsTransmissionZoneStyle[i].visibility = 'hidden';
		}
	}

		//next nibble (or roll over if buffer fully sent)
		iDataIdx = (iDataIdx+1)%aData.length; //prepare to send the next nibble

		//next step is the clock update
		currentstep = 0;
		iTimeoutID = setTimeout( "updateClock()", iShiftClockDelay );
 }
 
/**
* @function updateClock
* @description Update the transmission area with the new clock to be displayed and call updateData to update the data
*/ 
 function updateClock() {
	if (captorsTransmissionZoneStyle[iClock].visibility == 'visible')
	{
		captorsTransmissionZoneStyle[iClock].visibility = 'hidden';
	}
	else
	{
		captorsTransmissionZoneStyle[iClock].visibility = 'visible';
	}

	iTimeoutID = setTimeout( "updateData()", iDataDelay );//half period tempo
 }

/**
* @function Stop_Function
* @description Stop the Transmission
*/ 
 function Stop_Function()
 {
    clearTimeout (iTimeoutID);
    for (i=0; i<captorsTransmissionZone.length; i++)
    {
      document.body.removeChild(captorsTransmissionZone[i]);
		}
    document.body.removeChild(Background);
    captorsTransmissionZone=new Array();
    
	}

/**
* @function Stop_Function
* @description Stop the Transmission
*/ 
 function ReStart_Function()
 {
    //First get the size of the current transmission area
    getWindowSize();

    captorWidth = Math.round((iWidth) / captorsNumber);
    initializeTransmissionArea(captorsNumber,
                                560,200, borderSize, captorWidth,
                                captorHeight, zeroColor, oneColor, borderColor);

		var ocraEncoder = new com.gemalto.opticalreader.encoding.ocra();

		var dataDisplayOrder;
		
		if ( getDataOrderCallback != null ) {
			dataDisplayOrder = getDataOrderCallback()
		} else {
			dataDisplayOrder = [    com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CURRENCY,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TRANSACTION_AMOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_ACCOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FROM_ACCOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_BENIFICIARY_NAME,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TO_ACCOUNT,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_QUANTITY,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_REFERENCE,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FOLIO,
									com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CHALLENGE
								];
		}

		var tempDataArray = ocraEncoder.buildTlvAndChallenge( dataDisplayOrder, sStartCode, sCurrency, sTransactionAmount, sAccountNumber, sFromAccountNumber, sBenificiaryName, sToAccountNumber, sQuantity, sReference, sFolio, sChallenge);

		sData = ocraEncoder.lowLevelEncoding( tempDataArray[0] );
		aData = convertToArrayOfNibble( tempDataArray[0] );
		setChallengeCallback( tempDataArray[1] );

		updateData();
                                
	}
	