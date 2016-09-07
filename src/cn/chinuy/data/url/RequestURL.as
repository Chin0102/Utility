package cn.chinuy.data.url {
	import cn.chinuy.data.string.as2_escape;
	import cn.chinuy.data.string.isNull;
	
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	
	/**
	 * @author Chin
	 */
	public class RequestURL {
		
		protected var _pureUrl : String = "";
		protected var _paramKeys : Array;
		protected var _paramValues : Array;
		
		public function RequestURL( url : String ) {
			value = url;
		}
		
		public function set value( url : String ) : void {
			if( isNull( url ))
				return;
			_paramKeys = [];
			_paramValues = [];
			if( url.indexOf( "?" ) == -1 ) {
				_pureUrl = url;
				return;
			}
			var arr : Array = url.split( "?" );
			_pureUrl = arr.shift();
			var param : String = arr.join( "&" );
			if( isNull( param ))
				return;
			arr = param.split( "&" );
			for( var i : int = 0; i < arr.length; i++ ) {
				var kv : Array = String( arr[ i ]).split( "=" );
				_paramKeys.push( kv[ 0 ]);
				_paramValues.push( kv[ 1 ]);
			}
		}
		
		public function addParam( key : String, value : *, escape : Boolean = true ) : void {
			setParam( key, value, escape );
		}
		
		public function setParam( key : String, value : *, escape : Boolean = true ) : void {
			if( isNull( key ))
				return;
			if( escape )
				value = as2_escape( value );
			var i : int = _paramKeys.indexOf( key );
			if( i == -1 ) {
				_paramKeys.push( key );
				_paramValues.push( value );
			} else {
				_paramKeys[ i ] = key;
				_paramValues[ i ] = value;
			}
		}
		
		public function addParams( ps : String ) : void {
			var arr : Array = ps.split( "&" );
			var len : int = arr.length;
			for( var i : int = 0; i < len; i++ ) {
				var kv : Array = String( arr[ i ]).split( "=" );
				setParam( kv[ 0 ], kv[ 1 ]);
			}
		}
		
		/**
		 * 完整URL
		 */
		public function toString() : String {
			var s : String = pureUrl;
			var p : String = paramStr;
			if( p != "" )
				s += "?" + paramStr;
			return s;
		}
		
		/**
		 * 不带参数的URL
		 */
		public function get pureUrl() : String {
			return _pureUrl;
		}
		
		/**
		 * 字符串形式参数( a=1&b=2&c=3 )
		 */
		public function get paramStr() : String {
			if( _paramKeys ) {
				var len : int = _paramKeys.length;
				if( len > 0 ) {
					var arr : Array = [];
					for( var i : int = 0; i < len; i++ ) {
						arr.push( _paramKeys[ i ] + "=" + _paramValues[ i ]);
					}
					return arr.join( "&" );
				}
			}
			return "";
		}
		
		/**
		 * 对象形式参数( {a:1,b:2,c:3} )
		 */
		public function get paramObj() : Object {
			var obj : Object = {};
			if( _paramKeys ) {
				var len : int = _paramKeys.length;
				if( len > 0 ) {
					for( var i : int = 0; i < len; i++ ) {
						obj[ _paramKeys[ i ]] = _paramValues[ i ];
					}
				}
			}
			return obj;
		}
		
		public function send() : void {
			sendToURL( new URLRequest( toString()));
		}
	}
}
