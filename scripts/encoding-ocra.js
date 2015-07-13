//(c) Copyright 2011 Gemalto, Inc. All rights reserved.
/**
* @fileOverview This file contains the encoding functions required for the data encoding into OCRA optical reader protocol
* @author Gemalto
* @version 2.0
*/

if ( typeof(com) == 'undefined' ) {
    var com = {};
}
if ( typeof(com.gemalto) == 'undefined' ) {
    com.gemalto = {};
}
if ( typeof(com.gemalto.opticalreader) == 'undefined' ) {
    com.gemalto.opticalreader = {};
}
if ( typeof(com.gemalto.opticalreader.encoding) == 'undefined' ) {
    com.gemalto.opticalreader.encoding = {};
}

/**
* @class OCRA encoder class. It constains the methods to generate the TLVs to transmit to the optical reader, the challenge to send to the server, and the input to pass to the script optical-ocra.js.
*/
com.gemalto.opticalreader.encoding.ocra = function(){
    /////////////////////////////////////////////////////////////
    // public constants
    /////////////////////////////////////////////////////////////

    this.TAG_FIRST_BYTE             = 0x1F;

    this.TAG_ID_OFFSET              = 5;

    this.DATA_FORMAT_BCD            = 0 << this.TAG_ID_OFFSET;
    this.DATA_FORMAT_HEX            = 1 << this.TAG_ID_OFFSET;
    this.DATA_FORMAT_ASCII          = 2 << this.TAG_ID_OFFSET;
    //this.DATA_FORMAT_RFU_FORMAT   = 3 << this.TAG_ID_OFFSET;

    this.SYNC_PATTERN = '0FF'; //also defined as Start Criterion



    /////////////////////////////////////////////////////////////
    // public methods
    /////////////////////////////////////////////////////////////

    /**
    * build the OCRA TLV and the OCRA challenge
    * @param {array of members of the class com.gemalto.opticalreader.encoding.ocra.tags} aDisplayOrder determine in which order the data will be displayed on the optical reader screen. If a tag is missing in the array, the value will not be included in the generated TLV.
    * @param {String} sStartCode server start code
    * @param {String} sCurrency ISO code for currency. Eg: 0978 or 978 for EURO.
    * @param {String} sTransactionAmount transaction amount to sign. It includes the cents. Eg: 1500 for $15
    * @param {String} sAccount account
    * @param {String} sFromAccount from account
    * @param {String} sBenificaryName name of the benificiary
    * @param {String} sToAccount to account
    * @param {String} sQuantity quantity
    * @param {String} sReference reference
    * @param {String} sFolio folio
    * @param {String} sChallenge challenge
    * @return It returns an array of two string elements. The first element contains the TLV, the second contains the challenge computed for the OTP generation.
    */
    this.buildTlvAndChallenge = function ( aDisplayOrder, sStartCode, sCurrency, sTransactionAmount, sAccount, sFromAccount, sBeneficiaryName, sToAccount, sQuantity, sReference, sFolio, sChallenge) {

        var startCode = "20";
        var startCodeTLV = this._generateStartCodeTLV( sStartCode );
        var currencyTLV = this._generateCurrencyTLV( sCurrency );
        var transactionAmountTLV = this._generateAmountTLV( sTransactionAmount );
        var accountTLV = this._generateAccountTLV( sAccount );
        var fromAccountTLV = this._generateFromAccountTLV( sFromAccount );
        var benificiaryNameTLV = this._generateBenificiaryNameTLV( sBeneficiaryName );
        var toAccountTLV = this._generateToAccountTLV( sToAccount );
        var quantityTLV = this._generateQuantityTLV( sQuantity );
        var referenceTLV = this._generateReferenceTLV( sReference );
        var folioTLV = this._generateFolioTLV( sFolio );
        var challengeTLV = this._generateChallengeTLV( sChallenge );

        var elementsTLV = "";
        var challenge = "";

        if ( !this._isDisplayOrderValid( aDisplayOrder ) ) {
            throw com.gemalto.opticalreader.exception.INVALID_TAG_ORDER ;
        }
        
        if ( startCodeTLV != null ) {
            elementsTLV += startCodeTLV[0];
        }
        
        for ( var i = 0; i < aDisplayOrder.length; i++ ) {
            switch ( aDisplayOrder[i] ) {
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_START_CODE:
                // start code always comes first
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CURRENCY:
                if ( currencyTLV != null ) {
                    elementsTLV += currencyTLV[0];
                    challenge += currencyTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TRANSACTION_AMOUNT:
                if ( transactionAmountTLV != null ) {
                    elementsTLV += transactionAmountTLV[0];
                    challenge += transactionAmountTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_ACCOUNT:
                if ( accountTLV != null ) {
                    elementsTLV += accountTLV[0];
                    challenge += accountTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FROM_ACCOUNT:
                if ( fromAccountTLV != null ) {
                    elementsTLV += fromAccountTLV[0];
                    challenge += fromAccountTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_BENIFICIARY_NAME:
                if ( benificiaryNameTLV != null ) {
                    elementsTLV += benificiaryNameTLV[0];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TO_ACCOUNT:
                if ( toAccountTLV != null ) {
                    elementsTLV += toAccountTLV[0];
                    challenge += toAccountTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_QUANTITY:
                if ( quantityTLV != null ) {
                    elementsTLV += quantityTLV[0];
                    challenge += quantityTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_REFERENCE:
                if ( referenceTLV != null ) {
                    elementsTLV += referenceTLV[0];
                    challenge += referenceTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FOLIO:	
                if ( folioTLV != null ) {
                    elementsTLV += folioTLV[0];
                    challenge += folioTLV[1];
                }
                break;
            case com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CHALLENGE:	
                if ( challengeTLV != null ) {
                    elementsTLV += challengeTLV[0];
                    challenge += challengeTLV[1];
                }
                break;
            }
        }

        var elementsTlvLength = this._addLeftZeroPadding( ( elementsTLV.length / 2 ).toString(16), 2 );

        var checksum = this._checksum(startCode + elementsTlvLength + elementsTLV);

        challenge = this._addPadding( challenge, 128*2, true, '0' );

        var opticalFrame = this.SYNC_PATTERN + startCode + elementsTlvLength + elementsTLV + checksum;

        if ( opticalFrame.length > 120*2 ) {
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return new Array( opticalFrame, challenge );
    }

    /**
    * prepare a binary string properly formated for the display engine
    * @param {String} hexStrData string generated by buildTlvAndChallenge
    * @return It returns a string of 1s and 0s.
    */
    this.lowLevelEncoding = function ( hexStrData ) {
        var res = "";
        var clockState = '1';

        this._validateStrNotNullOrEmpty( hexStrData );
        this._validateHexFormat( hexStrData );

        for ( var i=0; i<hexStrData.length * 2; i++) {
            var character = parseInt( hexStrData.charAt(i % hexStrData.length), 16 );
            character = this._addLeftZeroPadding( character.toString(2), 4 );

            res = res + clockState + character.charAt(0) + character.charAt(1) + character.charAt(2) +  character.charAt(3);
            
            if ( clockState == '1' ) {
                clockState = '0';
            } else {
                clockState = '1';
            }
        }

        return res;
    }




    /////////////////////////////////////////////////////////////
    // private methods - all the private method names are prefixed with an underscore
    /////////////////////////////////////////////////////////////

    // the currency must preceed the amount in the tag order
    // the start code always comes first if present
    // the benificiary name must be just before the toaccount data
    this._isDisplayOrderValid = function ( aDisplayOrder ) {	

        if ( aDisplayOrder == null || aDisplayOrder.length == 0 ) {
            throw com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE;
        }
    
        for ( var i = 0; i < aDisplayOrder.length; i++ ) {
            if ( aDisplayOrder[i] == com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TRANSACTION_AMOUNT )  {
                for ( var j = i; j < aDisplayOrder.length; j++ ) {
                    if (aDisplayOrder[j] == com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CURRENCY) {
                        return false;
                    }
                }
            }
        }

        for ( var i = 0; i < aDisplayOrder.length; i++ ) {
            if ( aDisplayOrder[i] == com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_BENIFICIARY_NAME && aDisplayOrder[i+1] != com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TO_ACCOUNT )  {
                return false;
            }
        }

        return true;
    }

    this._generateStartCodeTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( data.length > 12 ) {  // up to 6 bytes
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_START_CODE, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateCurrencyTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );
        
        if ( formatedData == null ) {
            return null;
        }

        formatedData[1] = this._addLeftZeroPadding( formatedData[1], 4 );

        if ( formatedData[1].length == 4 && formatedData[1].charAt(0) != "0" ) { // 2 bytes - 3 BCD digits with a left 0 padding
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return new Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CURRENCY, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateAmountTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( data.length > 12 || (data.length == 12 && data.charAt(0) != "0" ) ) { // 11 digits or chars
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TRANSACTION_AMOUNT, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateAccountTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD | this.DATA_FORMAT_ASCII;

        var formatedData = this._charsetFormator( data, allowedFormats );
        
        if ( formatedData == null ) {
            return null;
        }

        if ( data.length > 34 ) { // 34 chars or digits
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_ACCOUNT, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateToAccountTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD | this.DATA_FORMAT_ASCII;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( data.length > 34 ) { // 34 chars or digits
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TO_ACCOUNT, formatedData[0], formatedData[1] ), formatedData[1] );

    }

    this._generateBenificiaryNameTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_ASCII;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( data.length > 26 ) { // 26 chars
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_BENIFICIARY_NAME, formatedData[0], formatedData[1] ), formatedData[1] );

    }
    
    this._generateFromAccountTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD | this.DATA_FORMAT_ASCII;
        
        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( data.length > 34 ) { // 34 chars or digits
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }


        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FROM_ACCOUNT, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateQuantityTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( formatedData[0] == this.DATA_FORMAT_BCD && data.length > 12 ) { // 12 digits or chars
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_QUANTITY, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateReferenceTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( formatedData[0] == this.DATA_FORMAT_BCD && data.length > 12 ) { // 12 digits or chars
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_REFERENCE, formatedData[0], formatedData[1] ), formatedData[1] );
    }

    this._generateFolioTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( formatedData[0] == this.DATA_FORMAT_BCD && data.length > 12 ) { // 12 digits or chars
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FOLIO, formatedData[0], formatedData[1] ), formatedData[1] );
    }
    
    this._generateChallengeTLV = function ( data ) {
        var allowedFormats = this.DATA_FORMAT_BCD;

        var formatedData = this._charsetFormator( data, allowedFormats );

        if ( formatedData == null ) {
            return null;
        }

        if ( formatedData[0] == this.DATA_FORMAT_BCD && data.length > 12 ) { // 12 digits
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return Array( this._generateElementTLV( com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CHALLENGE, formatedData[0], formatedData[1] ), formatedData[1] );
    }
    
    /*** FORMATS HELPERS ***/
    this._isSpecifiedFormatAllowed = function ( allowedFormats, format ) {
        return ( (allowedFormats & format) == format )
    }

    this._isBcdAllowed = function ( allowedFormats ) {
        return this._isSpecifiedFormatAllowed (allowedFormats, this.DATA_FORMAT_BCD);
    }

    this._isHexAllowed = function ( allowedFormats ) {
        return this._isSpecifiedFormatAllowed (allowedFormats, this.DATA_FORMAT_HEX);
    }

    this._isAsciiAllowed = function ( allowedFormats ) {
        return this._isSpecifiedFormatAllowed (allowedFormats, this.DATA_FORMAT_ASCII);
    }

    this._charsetFormator = function ( data, allowedFormats ) {
        if ( this._isNullOrEmptyString( data ) ) {
            return null;

        } else if ( this._isBcdAllowed( allowedFormats ) && this._isBcdFormat( data ) ) {
            return new Array ( this.DATA_FORMAT_BCD, this._addPaddingIfOddLength(data, false, '0') );

        } else if ( this._isHexAllowed( allowedFormats ) && this._isHexFormat( data ) ) { //&& !this._isLengthOdd ( data )
            return new Array ( this.DATA_FORMAT_HEX, this._addPaddingIfOddLength(data, false, '0') );

        } else if ( this._isAsciiAllowed( allowedFormats ) && this._isAsciiFormat( data ) ) {
            return new Array ( this.DATA_FORMAT_ASCII, this._hexAsciiConverter(data) );

        } else {
            throw com.gemalto.opticalreader.exception.INVALID_CHARSET;
        }
    }

    this._hexAsciiConverter = function ( data ) {
        var formatedData = "";

        for ( var i=0; i < data.length; i++ ) {
            var hexCode = data.charCodeAt(i).toString(16);
            formatedData = formatedData + this._addPaddingIfOddLength(hexCode, false, '0');
        }

        return formatedData;
    }
    /**********************/

    this._formatLengthChallenge = function ( challenge ) {
        this._validateLengthInBytes( challenge, 36 );

        var lengthChallenge = ( challenge.length / 2 ).toString(16);

        if (lengthChallenge.length == 1) {
            lengthChallenge = "0" + lengthChallenge;
        }

        return lengthChallenge;
    }

    this._generateElementTLV = function( tagId, format, data ) {
        var tag = this.TAG_FIRST_BYTE.toString(16) + this._addLeftZeroPadding( (format | tagId).toString(16), 2 );
        var lengthInByte = this._addLeftZeroPadding( (data.length / 2).toString(16), 2 );
        return tag + lengthInByte + data;
    }

    this._buildTLV = function ( format, data, maxLengh ) {
        if ( format== null && data == null ) {
            return new Array("","","","");
        }

        if ( format == null ) {
            throw com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE;
        }

        if ( data == null ) {
            throw com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE;
        }

        if ( format != this.DATA_FORMAT_NUMERICAL && format != this.DATA_FORMAT_HEXADECIMAL && format != this.DATA_FORMAT_ALPHA_NUMERICAL) {
            throw com.gemalto.opticalreader.exception.UNKNOWN_FORMAT;
        }

        var lengthInByte = data.length / 2; // from 0 to C

        return new Array( format + lengthInByte.toString(16) + data, format, lengthInByte.toString(16), data );
    }

    this._addLeftZeroPadding = function ( data, outputLength ) {
        return this._addPadding( data, outputLength, false, '0' );
    }

    this._addPaddingIfOddLength = function ( data, toTheRight, paddingCharacter ) {
        if ( data == null || toTheRight == null || paddingCharacter == null ) {
            throw com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE;
        }

        if ( this._isLengthOdd ( data ) ) {
            data = this._addPadding( data, data.length + 1, toTheRight, paddingCharacter );
        }

        return data;
    }

    this._isLengthOdd = function ( data ) {
        return data.length % 2 != 0;
    }

    this._addPadding = function ( data, outputLength, toTheRight, paddingCharacter ) {
        if ( data == null || outputLength == null || toTheRight == null || paddingCharacter == null ) {
            throw com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE;
        }

        if ( data.length > outputLength ) {
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        while ( data.length < outputLength ) {
            if ( toTheRight ) {
                data = data + paddingCharacter;
            } else {
                data = paddingCharacter + data;
            }
        }

        return data;
    }

    // computes the checksum
    this._checksum = function( hexaStrData ) {
        var primeLoohup = [142,110,120,201,209,183,172,166,62,49,34,22,18,15,13,87];
        var checksum = 0;

        this._validateHexFormat( hexaStrData );

        if ( hexaStrData.length % 2 != 0 ) {
            throw com.gemalto.opticalreader.exception.UNKNOWN_FORMAT;
        }

        for ( var i=0; i < hexaStrData.length; i++) {
            checksum  += primeLoohup[parseInt( hexaStrData.charAt(i), 16 )];
            i++;
            checksum  += primeLoohup[parseInt( hexaStrData.charAt(i), 16 )];
        }

        checksum = "" + (checksum & 32639).toString(16);

        return this._addLeftZeroPadding(checksum, 4);		
    }

    //////////////// FORMAT VALIDATION
    this._isNullOrEmptyString = function ( data ) {
        return ( data == null || data == "" );
    }

    this._validateStrNotNullOrEmpty = function ( data ) {
        if ( this._isNullOrEmptyString( data ) ) {
            throw com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE;
        }
    }

    this._isFormatValid = function ( stringData, regex ) {
        this._validateStrNotNullOrEmpty( stringData );

        for ( var i=0; i < stringData.length; i++ ) {
            if ( stringData.charAt(i).search(regex) != -1 ) {
                return false;
            }
        }

        return true;
    }

    this._isBcdFormat = function ( stringData ) {
        regex = /[^0-9]/;
        return this._isFormatValid( stringData, regex );
    }

    this._validateBcdFormat = function( data ) {
        this._validateStrNotNullOrEmpty( data );

        if ( ! this._isBcdFormat( data ) ) {
            throw com.gemalto.opticalreader.exception.INVALID_NUMERIC_FORMAT;
        }
    }

    this._isHexFormat = function ( stringData ) {
        return this._isFormatValid( stringData, /[^0-9A-Fa-f]/);
    }

    this._validateHexFormat = function ( data ) {
        this._validateStrNotNullOrEmpty( data );

        if ( !this._isHexFormat( data ) ) {
            throw com.gemalto.opticalreader.exception.INVALID_HEX_FORMAT;
        }
    }

    this._isAsciiFormat = function ( stringData ) {
        return this._isFormatValid( stringData, /[^0-9A-Za-z\*\?!,: _]/);
    }

    this._validateAsciiFormat = function ( data ) {
        this._validateStrNotNullOrEmpty( data );

        if ( !this._isAsciiFormat( data ) ) {
            throw com.gemalto.opticalreader.exception.INVALID_ALPHA_NUMERIC_FORMAT;
        }
    }

    // verify the length of a data
    // data is an hexadecimal string representing bytes
    // maxLengthInBytes is the maximum length in byte should have
    // return true if the data length is correct
    // throws an exception if the length is not correct, the content itself is not verified
    this._validateLengthInBytes = function( data, maxLengthInBytes ) {
        if ( data.length % 2 != 0 ) {
            throw com.gemalto.opticalreader.exception.INVALID_HEX_FORMAT;
        }

        this._validateLengthInNibbles( data, maxLengthInBytes * 2 );

        return true;
    }

    this._validateLengthInNibbles = function( data, maxLengthInNibbles ) {
        if ( data.length > maxLengthInNibbles ) {
            throw com.gemalto.opticalreader.exception.STRING_TOO_LONG;
        }

        return true;
    }
};

/**
* @class class containing the identifiers for the different data participating in the optical transmission
*/
com.gemalto.opticalreader.encoding.ocra.tags = function() {}
/**
* identifier for "currency"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CURRENCY            = 0x00;
/**
* identifier for "amount"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TRANSACTION_AMOUNT  = 0x01;
/**
* identifier for "account"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_ACCOUNT                = 0x02;
/**
* identifier for "from account"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FROM_ACCOUNT           = 0x03;
/**
* identifier for "to account"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_TO_ACCOUNT             = 0x04;
/**
* identifier for "quantity"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_QUANTITY            = 0x05;
/**
* identifier for "reference"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_REFERENCE           = 0x07;
/**
* identifier for "folio"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_FOLIO           = 0x08;
/**
* identifier for "challenge"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_CHALLENGE           = 0x09;
/**
* identifier for "start code"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_START_CODE           = 0x0A;
/**
* identifier for "benificiary name"
*/
com.gemalto.opticalreader.encoding.ocra.tags.TAG_ID_BENIFICIARY_NAME           = 0x0B;


/////////////////////////////////////////////////////////////
// exceptions
/////////////////////////////////////////////////////////////
/**
* @class class containing the exceptions that might be thrown by the encoder class
*/
com.gemalto.opticalreader.exception = function() {}
/**
* exception thrown when the input does not match any valid character set
*/
com.gemalto.opticalreader.exception.INVALID_CHARSET = "the data does not match any available charset";
/**
* exception thrown when an invalid null or empty string is received as input
*/
com.gemalto.opticalreader.exception.NULL_OR_EMPTY_VALUE = "the data cannot be null or empty";
/**
* exception thrown when the input length is too long
*/
com.gemalto.opticalreader.exception.STRING_TOO_LONG = "the string is too long";
/**
* exception thrown when the input does not have a known format
*/
com.gemalto.opticalreader.exception.UNKNOWN_FORMAT = "the specified format is unknown";
/**
* exception thrown when the input is an invalid numerical format
*/
com.gemalto.opticalreader.exception.INVALID_NUMERIC_FORMAT = "the data does not have a valid numeric format";
/**
* exception thrown when the input is an invalid hexadecimal format
*/
com.gemalto.opticalreader.exception.INVALID_HEX_FORMAT = "the data does not have a valid hexadecimal format";
/**
* exception thrown when the input is an invalid alpha-numerical format
*/
com.gemalto.opticalreader.exception.INVALID_ALPHA_NUMERIC_FORMAT = "the data does not have a valid alpha numeric format";
/**
* exception thrown when the plug-in is requested to pass the amount before the currency
*/
com.gemalto.opticalreader.exception.INVALID_TAG_ORDER = "invalid tag order";
