
          
	var strPassword;
	var charPassword;
	var minPasswordLength = 4;
	var baseScore = 0, score = 0;
	
	
	var numRepetidos = 0;
	var numSecuenciales = 0;
	var numDiferentes = 0;



	var bonusRepetidos = -10;
	var bonusSecuenciales = -5;
	var bonusDiferentes = 15;
	var bonusCombo = 0;
	

	var FirmaDigitalesComunes=new Array ("0123","1234","2345","3456","4567","5678", "6789", "7890","4321", "3210", "5432", "6543", "7654", "8765","9876","0987");
				 
function checkVal(obj)
{
	init(obj);
	
	if (charPassword.length >= minPasswordLength)
	{
		baseScore = 30;	
		analyzeString();	
		calcComplexity();		
	}
	else
	{
		baseScore = 0;
	}
	  return ((score>=60)?true:false);
}

function init(obj)
{
      strPassword= obj;
	charPassword = strPassword.split("");
		
	numRepetidos = 0;
	numSecuenciales = 0;
	numDiferentes = 0;
	bonusCombo = 0; 
	baseScore = 0;
	score =0;
}

function analyzeString ()
{	
	
      
	for (var i=0; i<FirmaDigitalesComunes.length; i++){
           if(FirmaDigitalesComunes[i]==strPassword){
	      bonusCombo = -130;
              return;
	   }
       }
       for (var i=1; i<charPassword.length;i++){
	  if(charPassword[i]==eval(charPassword[i-1] + " + 1") || 
            eval(charPassword[i] + " + 1")==charPassword[i-1] ) {
	     numSecuenciales++;
          }
       }
       
	bonusCombo = (numSecuenciales * bonusSecuenciales);
        charPassword.sort();

	for (var i=1; i<charPassword.length;i++){
  	   if(charPassword[i]==charPassword[i-1]) {
	      numRepetidos++;
	   }
	}

	bonusCombo = bonusCombo + (numRepetidos * bonusRepetidos);
        numDiferentes = 4 - numRepetidos;
        bonusCombo = bonusCombo + (numDiferentes * bonusDiferentes);
       
	if(numDiferentes==4 && numSecuenciales==0){
	   bonusCombo = bonusCombo + 10;
	}

	
}
	
function calcComplexity()
{
	score = baseScore + bonusCombo;
}	
	
