		function reset() {
			
		if (document.getElementById('changeLetters')){
			document.getElementById('changeLetters').checked = false ;
			changeKeyboard();}
		else{
				 if (document.getElementById('changeLettersfull')){
						document.getElementById('changeLettersfull').checked = false ;
						changeKeyboardfull();}
					}
		}
		
		function changeStyle() {
			if(document.getElementById("changeLetters")){
			if (document.getElementById("changeLetters").checked) {
				document.getElementById('upper').style.display = "none";
				document.getElementById('lower').style.display = "";
			 } else { 
				document.getElementById('upper').style.display = "";
				document.getElementById('lower').style.display = "none";
			 }
			}else
			{
				if (document.getElementById("changeLettersfull").checked) {
					document.getElementById('upperf').style.display = "none";
					document.getElementById('lowerf').style.display = "";
				 } else { 
					document.getElementById('upperf').style.display = "";
					document.getElementById('lowerf').style.display = "none";
				 }		 }
		}
					
					function changeKeyboard() {
						printtclado(randomNum,'lower'); 
					    printSmallErase('lower');
						
						printtcladon(randomNum,'upper'); 
						printSmallErasen('upper');
						
					}
					function changeKeyboardfull() {
						printtclado(randomNum,'lowerf'); 
						printtclado(randomAlpha,'lowerf'); 
						printtclado(randomSpChar,'lowerf');
						printSmallErase('lowerf');
						
						printtclado(randomNum,'upperf'); 
						printtclado(randomAlphaU,'upperf'); 
						printtclado(randomSpChar,'upperf');
						printSmallErase('upperf');
					
					}
					

					// ** ARRAYS FOR ALPHABETS, NUMBERS AND SPECIAL CHARACTERS **
						var alphaArrayU = new Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
						var alphaArray = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");
						var numArray = new Array("1","2","3","4","5","6","7","8","9","0");
						var SpCharArray = new Array("!","@","#","$","%","&","*","(",")","+","=","?",".",",","'",";","[","]","^","`","{","}","~",">","<","_","/","|",":","\"","\\","-");
						SpCharArray = new Array("_","-") ;
						
						
						// ** INTERMEDIATE ARRAYS WHICH WILL CARRY THE RANDAMIZED VALUES **
						var randomAlpha = chooseNum(26, alphaArray);
						var randomAlphaU = chooseNum(26, alphaArrayU);
						var randomNum = chooseNum(10, numArray);
						var randomSpChar = chooseNum(2, SpCharArray);

						// ** OTHER VARIABLES **
						var caps = 0;
						var entry_field="";
						var textValue="";
						
						function chooseNum(nums, numArr)
						{
						if(nums>numArr.length)
						{
						alert('You are trying to choose more elements from the array than it has!');
						return false;
						}
						var chooseArr=new Array();
						var tempArr=numArr;
						for(var i=0; i<nums; i++)
						{
						chooseArr[chooseArr.length]=tempArr[Math.round((tempArr.length-1)*Math.random())];
						var temp=chooseArr[chooseArr.length-1];
						for(var j=0; j<tempArr.length; j++)
						{
						if(tempArr[j]==temp)
						{
						tempArr[j]=null;
						var tempArr2=new Array();
						for(var k=0; k<tempArr.length; k++)
						if(tempArr[k]!=null)
						tempArr2[tempArr2.length]=tempArr[k];
						tempArr=tempArr2;
						break;
						}
						}
						}
						return chooseArr;
						}
						
						function printtclado(randomArray, id)
						{
							
							var out;
							for(var n=0;n<randomArray.length;n++)
							{
									out = '<input class=\"button_off\" type=\"button\" style=\"width:19px;\" onmouseup=\"this.className=\'button_on\';\" onmouseover=\"window.status = \'\';this.className=\'button_on\'\; return true;" onmousedown=\"this.className=\'button_press\';\" onmouseout=\"this.className=\'button_off\'\" onclick=\"escribir(\'';
									out += randomArray[n];
									out += '\');\"';
									out += 'value=\"' +  randomArray[n] + '\"';
									out += '\/>';
									document.getElementById(id).innerHTML+=out;
								
							}
						}
						function printtcladon(randomArray, id)
						{
							
							var out;
							for(var n=0;n<randomArray.length;n++)
							{
									out = '<input class=\"button_offn\" type=\"button\" style=\"width:19px;\" onmouseup=\"this.className=\'button_onU\';\" onmouseover=\"window.status = \'\';this.className=\'button_onU\'\; return true;" onmousedown=\"this.className=\'button_pressn\';\" onmouseout=\"this.className=\'button_offn\'\" onclick=\"escribir(\'';
									out += randomArray[n];
									out += '\');\"';
									out += 'value=\"' +  randomArray[n] + '\"';
									out += '\/>';
									document.getElementById(id).innerHTML+=out;
								
							}
						}
						
						function printEraseBottom(id) {
							var out = '<input class=\"button_off\" type=\"button\" style=\"width:52px !important ;\" onmouseup=\"this.className=\'button_on\';\" onmouseover=\"window.status = \'\';this.className=\'button_on\'\; return true;" onmousedown=\"this.className=\'button_press\';\" onmouseout=\"this.className=\'button_off\'\" onclick=\"javascript:clearField();\"';
									out += 'value=\"Borrar Todo\" ';
									out += 'id=\"btn_reset\" ';
									out += '\/>';
									document.getElementById(id).innerHTML+=out;
						
						}
						
						function printSmallErase(id) {
							var out = '<input class=\"button_off\" type=\"button\" style=\"width:59px !important; font-size:9px;\" onmouseup=\"this.className=\'button_on\';\" onmouseover=\"window.status = \'\';this.className=\'button_on\'\; return true;" onmousedown=\"this.className=\'button_press\';\" onmouseout=\"this.className=\'button_off\'\" onclick=\"javascript:clearField();\"';
									out += 'value=\"BORRAR\" ';
									out += 'id=\"btn_reset\" ';
									out += '\/>';
									document.getElementById(id).innerHTML+=out;
						}
						
						function printSmallErasen(id) {
							var out = '<input class=\"button_offn\" type=\"button\" style=\"width:56px !important; font-size:9px;\" onmouseup=\"this.className=\'button_onU\';\" onmouseover=\"window.status = \'\';this.className=\'button_onU\'\; return true;" onmousedown=\"this.className=\'button_press\';\" onmouseout=\"this.className=\'button_offn\'\" onclick=\"javascript:clearField();\"';
									out += 'value=\"BORRAR\" ';
									out += 'id=\"btn_reset\" ';
									out += '\/>';
									document.getElementById(id).innerHTML+=out;
						}