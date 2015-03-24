package cn.chinuy.data.url {
	import cn.chinuy.data.string.as2_escape;
	import cn.chinuy.data.string.isNull;
	
	import flash.net.URLRequest;
	import flash.net.sendToURL;
	
	/**
	 * @author Chin
	 */
	public class RequestURL {
		public static function parseParam( paramStr : String ) : Object {
			var obj : Object = {};
			if( !isNull( paramStr )) {
				var arr : Array = paramStr.split( "&" );
				var len : int = arr.length;
				for( var i : int; i < len; i++ ) {
					var keyValue : Array = String( arr[ i ]).split( "=" );
					obj[ keyValue[ 0 ]] = keyValue[ 1 ];
				}
			}
			return obj;
		}
		
		protected var _url : String = "";
		protected var _pureUrl : String = "";
		protected var _paramStr : String = "";
		protected var _paramObj : Object = {};
		
		public function RequestURL( url : String ) {
			value = url;
		}
		
		public function set value( url : String ) : void {
			if( isNull( url ))
				return;
			_url = url;
			var arr : Array = _url.split( "?" );
			_pureUrl = arr.shift();
			_paramStr = arr.join( "&" );
			_paramObj = parseParam( _paramStr );
		}
		
		public function addParam( key : String, value : *, escape : Boolean = true ) : void {
			if( isNull( key ))
				return;
			if( escape )
				value = as2_escape( value );
			_paramObj[ key ] = value;
			if( _paramStr != "" )
				_paramStr += "&";
			_paramStr += key + "=" + value;
			_url = _pureUrl + "?" + _paramStr;
		}
		
		/**
		 * 完整URL
		 */
		public function toString() : String {
			return _url;
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
			return _paramStr;
		}
		
		/**
		 * 对象形式参数( {a:1,b:2,c:3} )
		 */
		public function get paramObj() : Object {
			return _paramObj;
		}
		
		public function send() : void {
			sendToURL( new URLRequest( _url ));
		}
	}
}
