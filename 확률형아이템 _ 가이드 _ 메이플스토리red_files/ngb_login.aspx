
if ( document.location.protocol.toLowerCase() == 'https:' )
{
	document.write( '<scr' + 'ipt src ="https://ssl.nx.com/s1/global/ngb_RSAHash.js" type="text/javascript"></scr' + 'ipt>' );
}
else
{
	document.write( '<scr' + 'ipt src ="http://js.nx.com/s1/global/ngb_RSAHash.js" type="text/javascript"></scr' + 'ipt>' );
}

var NgbSecurity = new function __NgbSecurity()
{
    var _retryCount = 0;
	var _e;
	var _m;
	var _hash;
	var _handler;
	var _url;
	var _message;
	var _errormessage;
	var _timer;
	var _timeout;
	var _header;
	var _WUMPEJ2657KG5W0S = new Array();

	this.InitData = function()
	{
		if ( typeof( _url ) != 'undefined' && typeof( _timer ) != 'undefined' )
			return;
		
		_WUMPEJ2657KG5W0S.length = 0;
	}
	
	this.AddData = function( _KEBJ2SO0ATUGE8YP )
	{
		if ( typeof( _url ) != 'undefined' && typeof( _timer ) != 'undefined' )
			return;
			
		_WUMPEJ2657KG5W0S[ _WUMPEJ2657KG5W0S.length ] = _KEBJ2SO0ATUGE8YP;
	}
	
	this.SetURL = function( url, message, errormessage )
	{
		_url = url;
		_message = message;
		_errormessage = errormessage;
	}
	
	this.SetTimeout = function( timeout )
	{
		_timeout = timeout;
	}
	
	this.SetEncryptInfo = function( e, m, hash )
	{
		_e = e;
		_m = m;
		_hash = hash;
	}
	
	this.Encrypt = function( handler )
	{
		if ( _WUMPEJ2657KG5W0S.length == 0 || typeof( handler ) == 'undefined' )
			throw Exception;
			
		_handler = handler;
		
		if ( typeof( _url ) != 'undefined' )
		{
			if ( typeof( _timer ) != 'undefined' )
			{
				if ( typeof( _message ) != 'undefined' )
					alert( _message );
				else
					alert( '��û�� ó�����Դϴ�.' );

				return;
			}
			
			if ( typeof( _timeout ) != 'undefined' )
				_timer = setTimeout( 'NgbSecurity.ExpireRequest()',_timeout );
			else
				_timer = setTimeout( 'NgbSecurity.ExpireRequest()', 10000 );
			
			AppendScript( _url );
		}
		else
		{
			if ( typeof( _e ) == 'undefined' || typeof( _m ) == 'undefined' )
				throw Exception;
			
			ProcessEncrypt();
		}
	}
	
	this.ExpireRequest = function()
	{
		clearTimeout( _timer );
		_timer = undefined;

		_WUMPEJ2657KG5W0S.length = 0;
		
		if ( typeof( _errormessage ) != 'undefined' ) {
			alert( _errormessage );
        }
		else {
            _retryCount = _retryCount + 1;
            if( _retryCount < 3 ) {
			    alert( '��û �ð��� �ʰ��Ǿ����ϴ�.' );
            }
            else {
                alert('����� ��Ʈ��ũ ���� ���°� �Ҿ����ϰų�, �������� ���� �õ��� ������ ȯ���ϼ� �ֽ��ϴ�.\r\n�ؽ� �����ͷ� �������ּ���');
            }
        }
	}
	
	this.HandleResponse = function( responseXML )
	{
		if ( typeof( _timer ) != 'undefined' )
		{
			clearTimeout( _timer );
			_timer = undefined;
		
			var resultObject = NxamlParser.ParseXmlText( responseXML );
			EncryptHandler( responseXML, resultObject );
		}
	}
	
	this.HashString = function( _D4SL80OSF4D34T1P )
	{
		var hashString = NgbHash.HMAC_SHA256_MAC2( "4E65786F6E55736572", _D4SL80OSF4D34T1P );
		return hashString;
	}
	
	this.HashString2 = function( _1J3Y4K9SSHK8IXM2, _D4SL80OSF4D34T1P, _ACL0OMWMP3KQ481L )
	{
		var hashString = _1J3Y4K9SSHK8IXM2 + NgbHash.HMAC_SHA256_MAC( _ACL0OMWMP3KQ481L, NgbHash.HMAC_SHA256_MAC2( "4E65786F6E55736572", _D4SL80OSF4D34T1P ));
		return hashString;
	}
	
	var AppendScript = function( src )
	{
		var script = document.createElement( 'script' );
		
		script.src = src;
		script.type = 'text/javascript';
		script.charset = 'ks_c_5601-1987';
	
		document.getElementsByTagName( 'head' )[ 0 ].appendChild( script );
	}
	
	var ProcessEncrypt = function()
	{
		setMaxDigits( 131 );
		
		var key = new NgbRSA.RSAKeyPair( _e, '', _m );
		var _KEBJ2SO0ATUGE8YP = '';
		
		if ( typeof( _hash ) != 'undefined' )
			_KEBJ2SO0ATUGE8YP = _hash + '\\';
			
		for ( var i = 0; i < _WUMPEJ2657KG5W0S.length; i++ )
		{
			_KEBJ2SO0ATUGE8YP += NgbRSA.utf8base64encode( _WUMPEJ2657KG5W0S[ i ] );
			
			if ( i < _WUMPEJ2657KG5W0S.length - 1 )
				_KEBJ2SO0ATUGE8YP += '\\';
		}
		
		var val = EncryptString( key, _KEBJ2SO0ATUGE8YP );
		_WUMPEJ2657KG5W0S.length = 0;
		
		_handler( val );
	}
	
	var EncryptHandler = function( responseXML, resultObject )
	{
		if ( typeof( resultObject.result.e ) != 'undefined' 
			&& typeof( resultObject.result.m ) != 'undefined' 
			&& typeof( resultObject.result.h ) != 'undefined' )
		{
			_e = resultObject.result.e;
			_m = resultObject.result.m;
			_hash = resultObject.result.h;
			
			ProcessEncrypt();
		}
		else
		{
			alert( "�α��� ó������ �� ������ �߻��Ͽ����ϴ�." );
			return;
		}
	}
	
	var EncryptString = function( key, _NIDYFBS7XFF4L8FW )
	{
		if ( key.chunkSize > key.digitSize - 11 )
		{
			return 'Error';
		}
		
		var a = new Array();
		var sl = _NIDYFBS7XFF4L8FW.length;
		
		var i = 0;
		while ( i < sl )
		{
			a[ i ] = _NIDYFBS7XFF4L8FW.charCodeAt( i );
			i++;
		}
		
		var al = a.length;
		var result = '';
		var j, k, block;
		for ( i = 0; i < al; i += key.chunkSize )
		{
			block = new BigInt();
			j = 0;
			var x;
			var msgLength = ( i + key.chunkSize ) > al ? al % key.chunkSize : key.chunkSize;
			
			var b = new Array();
			for ( x = 0; x < msgLength; x++ )
			{
				b[ x ] = a[ i + msgLength - 1 - x ];
			}
			b[ msgLength ] = 0;
			var paddedSize = Math.max( 8, key.digitSize - 3 - msgLength );
		
			for ( x = 0; x < paddedSize; x++ )
			{
				b[ msgLength + 1 + x ] = Math.floor(Math.random() * 254) + 1;
			}
			b[ key.digitSize - 2 ] = 2;
			b[ key.digitSize - 1 ] = 0;
			
			for ( k = 0; k < key.digitSize; ++j )
			{
				block.digits[ j ] = b[ k++ ];
				block.digits[ j ] += b[ k++ ] << 8;
			}

			var crypt = key.barrett.powMod( block, key.e );
			var text = key.radix == 16 ? biToHex( crypt ) : biToString( crypt, key.radix );
			result += text + ' ';
		}
		
		return result.substring( 0, result.length - 1 );
	}
}

var NgbLogin = new function __NgbLogin()
{
	var _isLoginProcessing = false;
	var _retryCount = 0;
	var _codeRegSite = 0;
	var _strRedirect;
	var _isPhone = false;
	var _header;
	var _hashKey;
	var __MU839RU40K67OIGW;
	var __42NYGV5T9LOS4R26;
	var _isLogin2;
	var _callBackMethod;
	
	var _hashtimer;
	
	var _HCB701I26F1146DE;
	
	var _isInvalidPasswordHashKeyString = false;
    var _isFailover = false;
    var _isSLogin = '0';
	
	this.SetData = function( _MU839RU40K67OIGW, _42NYGV5T9LOS4R26, codeRegSite, strRedirect, isPhone, isSLogin )
	{
		__MU839RU40K67OIGW = _MU839RU40K67OIGW;
		__42NYGV5T9LOS4R26 = _42NYGV5T9LOS4R26;
		_codeRegSite = codeRegSite;
		_strRedirect = strRedirect;
        _isPhone = isPhone;
        _isSLogin = isSLogin;
	}
	
	this.InitLoginProcessing = function()
	{
		_isLoginProcessing = false;
	}
	
	this.SubmitLogin = function()
	{
		var strDomain = NgbLogin.GetLoginURL();
		var strEncData = arguments [ 1 ][ 0 ];
		var codeRegSite = arguments [ 1 ][ 1 ];
		var strRedirect = arguments [ 1 ][ 2 ];
		var isPhone = arguments [ 1 ][ 3 ];
		var isLogin2 = arguments [ 1 ][ 4 ];
        var strCallBackMethod = arguments[1][5];
        var isSLogin = arguments[1][6];

		if ( strEncData == 'Error' )
		{
			alert( "�α��� ó������ �� ������ �߻��Ͽ����ϴ�." );
			return false;
		}
		
		if ( _isLoginProcessing )
		{
			alert( "�α��� �ϴ� ���Դϴ�. ��ø� ��ٷ��ּ���." );
			return false;
		}
		_isLoginProcessing = true;
		
		if( isLogin2 == false )
		{		
			NgbClientForm.AddChildForSubform( 'strEncData', strEncData );
            NgbClientForm.AddChildForSubform( 'codeRegSite', codeRegSite );
            NgbClientForm.AddChildForSubform( 'isSLogin', isSLogin );
			
			if ( typeof( strRedirect ) != 'undefined' )
				NgbClientForm.AddChildForSubform( 'strRedirect', strRedirect );
            else
                NgbClientForm.AddChildForSubform( 'strRedirect', escape( document.location.href ) );
				
			if ( typeof( isPhone ) == 'undefined' )
				isPhone = false;

			if ( isPhone == false )
				NgbClientForm.SubmitForm( 'https://' + strDomain + '/login/page/loginproc.aspx' );
			else
				NgbClientForm.SubmitForm( 'https://' + strDomain + '/login/page/loginphone.aspx' );
		}
		else
		{
			var iframe;
			
			try
			{
				iframe = document.createElement( "<iframe name='iframe1' />" );
			} catch ( ex ) {
				iframe = document.createElement( "iframe" );
				iframe.name = "iframe1";
			}
			
			iframe.src = "javascript:'<script>window.onload=function(){document.write(\\'<script>document.domain=\\\"nexon.com\\\";<\\\\/script>\\');document.close();};<\/script>'";
			iframe.style.display = "none";
			document.body.appendChild( iframe ); 

			var encData = document.createElement( "input" );
			encData.setAttribute( "type", "hidden" );
			encData.setAttribute( "name", "strEncData" );
			encData.setAttribute( "value", strEncData );
			
			var callBackMethod = document.createElement( "input" );
			callBackMethod.setAttribute( "type", "hidden" );
			callBackMethod.setAttribute( "name", "strCallBackMethod" );
			callBackMethod.setAttribute( "value", strCallBackMethod );

			var form = document.createElement( "form" );
			form.method = "post";
			form.target = "iframe1";
			form.action = "https://" + strDomain + "/login/page/loginproc2.aspx";
			form.appendChild( encData );
			form.appendChild( callBackMethod );

			document.body.appendChild( form );
			
			NgbLogin.PollSubmit( form );
		}
	}
	
	this.PollSubmit = function( form )
	{
		try
		{
			form.submit();
		}
		catch( e )
		{
			setTimeout(function() { // set a timeout to give browsers a chance to recognize the <iframe> 
				NgbLogin.PollSubmit( form );
			}, 100 );
		}
	}

    this.SLogin = function (_MU839RU40K67OIGW, _42NYGV5T9LOS4R26, codeRegSite, strRedirect) {
        NgbLogin.SetData(_MU839RU40K67OIGW, _42NYGV5T9LOS4R26, codeRegSite, strRedirect, false, '1');
        _isLogin2 = false;

        if (_MU839RU40K67OIGW.indexOf('@') != -1 )
        {
            var arrEmail = _MU839RU40K67OIGW.split('@');

            if (arrEmail.length != 2 || arrEmail[0] == '' || arrEmail[1] == '' || _MU839RU40K67OIGW.indexOf(' ') != -1 )
            {
                alert('���̵� Ȯ���� �ּ���.');
                return;
            }

            if (typeof (_hashtimer) != 'undefined') {
                alert('�α��� �ϴ� ���Դϴ�. ��ø� ��ٷ��ּ���.');
                return;
            }

            _isFailover = false;
            _HCB701I26F1146DE = _MU839RU40K67OIGW;
            AuthSystem.GetPasswordHashKey(_MU839RU40K67OIGW, NgbLogin.HashHandler);

            _hashtimer = setTimeout('NgbLogin.ExpireHashProcess()', 5000);
        }
		else
        {
            NgbLogin.MemberLogin();
        }
	}

    this.Login = function (_MU839RU40K67OIGW, _42NYGV5T9LOS4R26, codeRegSite, strRedirect, isPhone )
	{
		NgbLogin.SetData( _MU839RU40K67OIGW, _42NYGV5T9LOS4R26, codeRegSite, strRedirect, isPhone );
		_isLogin2 = false;
		
		if ( _MU839RU40K67OIGW.indexOf( '@' ) != -1 )
		{
			var arrEmail = _MU839RU40K67OIGW.split( '@' );
			
			if ( arrEmail.length != 2 || arrEmail[ 0 ] == '' || arrEmail[ 1 ] == '' || _MU839RU40K67OIGW.indexOf( ' ' ) != -1 )
			{
				alert( '���̵� Ȯ���� �ּ���.' );
				return;
			}
			
			if ( typeof( _hashtimer ) != 'undefined' )
			{
				alert( '�α��� �ϴ� ���Դϴ�. ��ø� ��ٷ��ּ���.' );
				return;
			}
			
			_isFailover = false;
			_HCB701I26F1146DE = _MU839RU40K67OIGW;
			AuthSystem.GetPasswordHashKey( _MU839RU40K67OIGW, NgbLogin.HashHandler );
			
			_hashtimer = setTimeout( 'NgbLogin.ExpireHashProcess()', 5000 );
		}
		else
		{
			NgbLogin.MemberLogin();
		}
	}
	
	this.Login2 = function( _MU839RU40K67OIGW, _42NYGV5T9LOS4R26, callBackMethod )
	{
		if( typeof( callBackMethod ) == "undefined" || callBackMethod == "" )
		{
			alert( "�α��� ó������ �� ������ �߻��Ͽ����ϴ�." );
			return;
		}
		
		NgbLogin.SetData( _MU839RU40K67OIGW, _42NYGV5T9LOS4R26 );
		_isLogin2 = true;
		_callBackMethod = callBackMethod;
		
		if ( _MU839RU40K67OIGW.indexOf( '@' ) != -1 )
		{
			var arrEmail = _MU839RU40K67OIGW.split( '@' );
			
			if ( arrEmail.length != 2 || arrEmail[ 0 ] == '' || arrEmail[ 1 ] == '' )
			{
				alert( '���̵� Ȯ���� �ּ���.' );
				return;
			}
			
			if ( typeof( _hashtimer ) != 'undefined' )
			{
				alert( '�α��� �ϴ� ���Դϴ�. ��ø� ��ٷ��ּ���.' );
				return;
			}
			
			_isFailover = false;
			_HCB701I26F1146DE = _MU839RU40K67OIGW;
			AuthSystem.GetPasswordHashKey( _MU839RU40K67OIGW, NgbLogin.HashHandler );
			
			_hashtimer = setTimeout( 'NgbLogin.ExpireHashProcess()', 5000 );
		}
		else
		{
			NgbLogin.MemberLogin();
		}
	}
	
	this.ExpireHashProcess = function()
	{
		clearTimeout( _hashtimer );
		_hashtimer = undefined;
		_retryCount = _retryCount + 1;
        if( _retryCount < 3 ) {
			alert( '��û �ð��� �ʰ��Ǿ����ϴ�.' );
        }
        else {
            alert('����� ��Ʈ��ũ ���� ���°� �Ҿ����ϰų�, �������� ���� �õ��� ������ ȯ���ϼ� �ֽ��ϴ�.\r\n�ؽ� �����ͷ� �������ּ���');
        }
	}
	
	this.MemberLogin = function()
	{
		_MU839RU40K67OIGW = __MU839RU40K67OIGW;
		_42NYGV5T9LOS4R26 = __42NYGV5T9LOS4R26;
		codeRegSite = _codeRegSite;
		strRedirect = _strRedirect;
        isPhone = _isPhone;
        isSLogin = _isSLogin;
		
		var strDomain = NgbLogin.GetLoginURL();
		_MU839RU40K67OIGW = NgbString.Trim( _MU839RU40K67OIGW );
		_42NYGV5T9LOS4R26 = NgbString.Trim( _42NYGV5T9LOS4R26 );
		
		if ( typeof( codeRegSite ) == 'undefined' )
			codeRegSite = 0;
			
		if ( typeof( isPhone ) == 'undefined' )
            isPhone = false;

        if (typeof (isSLogin) == 'undefined')
            isSLogin = '0';
			
		if ( _MU839RU40K67OIGW == '' || _MU839RU40K67OIGW.indexOf( ' ' ) != -1 )
		{
			alert( '���̵� �Է��� �ּ���.' );
			return;
		}
		else if ( _42NYGV5T9LOS4R26 == '' )
		{
			alert( '��й�ȣ�� �Է��� �ּ���.' );
			return;
		}
		
		_codeRegSite = codeRegSite;
		_strRedirect = strRedirect;
        _isPhone = isPhone;
        _isSLogin = isSLogin;
		
		try
		{
			NgbSecurity.InitData();
			
			NgbSecurity.AddData( _MU839RU40K67OIGW );
			NgbSecurity.AddData( _MU839RU40K67OIGW.indexOf( '@' ) != -1 ? NgbSecurity.HashString2( _header, _42NYGV5T9LOS4R26, _hashKey ) : _42NYGV5T9LOS4R26 );
			
			NgbSecurity.SetURL( 'https://' + strDomain + '/login/page/encryptinfo.aspx', '�α��� �ϴ� ���Դϴ�. ��ø� ��ٷ��ּ���.' );
			NgbSecurity.Encrypt( NgbLogin.EncryptHandler );
		}
		catch( e )
		{
            NgbEVM.AddCommand(NgbEVM.k_nEventType_onPageEnd, new NgbEVMDelegator(NgbLogin.SubmitLogin), '', _codeRegSite, _strRedirect, _isPhone, _isLogin2, _callBackMethod, _isSLogin );
		}
	}
	
	this.EncryptHandler = function( encData )
	{
        NgbEVM.AddCommand(NgbEVM.k_nEventType_onPageEnd, new NgbEVMDelegator(NgbLogin.SubmitLogin), encData, _codeRegSite, _strRedirect, _isPhone, _isLogin2, _callBackMethod, _isSLogin );
	}

	this.Logout = function( strURL )
	{
		var strDomain = NgbLogin.GetLoginURL();
	
		if ( typeof( strURL ) == 'undefined' )
			strURL = document.location.href;
		
		document.location.href = 'http://' + strDomain + '/login/page/logout.aspx?redirect=' + escape( strURL );
	}
	
	this.GetLoginURL = function()
	{
		var strDomain;
		
		try
		{
			strDomain = NgbUrl.GetDomainURL();
		}
		catch ( e )
		{
			strDomain = 'login.nexon.com';
		}
		
		switch ( strDomain )
		{
			case 'df.nexon.com' : 
			case 'dflogin.nexon.com' : 
				return 'dflogin.nexon.com';
				
			default : 
				return 'login.nexon.com';
		}
	}

    this.LoginTPA = function( strRedirect, action, authlevel, isSLogin )
	{
		var strDomain = NgbLogin.GetLoginURL();
	
        if (typeof (strRedirect) == 'undefined' || !strRedirect)
			strRedirect =  document.location.href;

        var url = 'http://' + strDomain + '/login/' + action + '?redirect=' + escape(strRedirect);

        if (typeof (authlevel) != 'undefined' && authlevel == "1") {
            url += "&authlevel=1";
        }        

        if (typeof (isSLogin) != 'undefined' && isSLogin == "1") {
            url += "&isSLogin=1";
        }   
         
        document.location.href = url;
	}	

    this.LoginFacebook = function( strRedirect, authlevel )
	{
        NgbLogin.LoginTPA(strRedirect, 'facebook', authlevel);
	}

    this.LoginGoogle = function( strRedirect, authlevel )
	{
        NgbLogin.LoginTPA(strRedirect, 'google', authlevel);
	}	

    this.LoginNaver = function( strRedirect, authlevel)
	{
        NgbLogin.LoginTPA(strRedirect, 'naver', authlevel);
}	

    this.LoginApple = function (strRedirect, authlevel) {
        NgbLogin.LoginTPA(strRedirect, 'apple', authlevel);
    }	

    this.SLoginFacebook = function (strRedirect, authlevel) {
        NgbLogin.LoginTPA(strRedirect, 'facebook', authlevel, '1');
    }

    this.SLoginGoogle = function (strRedirect, authlevel) {
        NgbLogin.LoginTPA(strRedirect, 'google', authlevel, '1');
    }

    this.SLoginNaver = function (strRedirect, authlevel) {
        NgbLogin.LoginTPA(strRedirect, 'naver', authlevel, '1');
    }	

    this.SLoginApple = function (strRedirect, authlevel) {
        NgbLogin.LoginTPA(strRedirect, 'apple', authlevel, '1');
    }	

	this.HashHandler = function( resultObject, responseXML )
	{
		try
		{
			clearTimeout( _hashtimer );
			_hashtimer = undefined;
		
			if ( typeof( resultObject.PasswordHashKeyString ) != 'undefined' && resultObject.PasswordHashKeyString != '' )
			{
				var result = resultObject.PasswordHashKeyString;
				var info = result.split(':');
				_header = info[0] + ':' + info[1] + ':' + info[2] + ':';
				_hashKey = info[3];
				
				_isInvalidPasswordHashKeyString = false;
			}
			else
			{
				_isInvalidPasswordHashKeyString = true;
			}
		}
		catch ( e )
		{
			_isInvalidPasswordHashKeyString = true;
		}
		
		if ( _isInvalidPasswordHashKeyString == true )
		{
			alert( "�α��� ó������ �� ������ �߻��Ͽ����ϴ�." );
			return;
		}
		else
		{
			NgbLogin.MemberLogin();
		}
	}
}
