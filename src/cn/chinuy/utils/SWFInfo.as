package cn.chinuy.utils {
	import cn.chinuy.data.string.isNull;
	import cn.chinuy.data.string.toBoolean;
	import cn.chinuy.data.string.toNumber;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.external.ExternalInterface;
	import cn.chinuy.data.url.URL;
	
	/**
	 * @author Chin
	 */
	public class SWFInfo {
		
		public static var RefererJSCode : Array = [ "window.location.href.toString" ];
		
		private var _flashvars : Object = {};
		private var _root : DisplayObjectContainer;
		private var _url : URL;
		private var _referer : URL;
		private var _jsable : Boolean;
		
		public function SWFInfo( root : DisplayObjectContainer ) {
			_root = root;
			if( _root ) {
				var info : LoaderInfo = _root.loaderInfo;
				_url = new URL( info.url );
				readParam( info.parameters );
			}
			getReferer();
		}
		
		public function get root() : DisplayObjectContainer {
			return _root;
		}
		
		public function stringVar( key : String, defaultVar : String = "" ) : String {
			var v : String = _flashvars[ key ];
			if( isNull( v ))
				v = defaultVar;
			return v;
		}
		
		public function booleanVar( key : String, defaultVar : Boolean = false ) : Boolean {
			return toBoolean( _flashvars[ key ], defaultVar );
		}
		
		public function numberVar( key : String, defaultVar : Number = NaN, checkNull : Boolean = false ) : Number {
			return toNumber( _flashvars[ key ], defaultVar, checkNull );
		}
		
		public function get flashvars() : Object {
			return _flashvars;
		}
		
		public function get url() : URL {
			return _url;
		}
		
		public function get referer() : URL {
			return _referer;
		}
		
		public function get jsable() : Boolean {
			return _jsable;
		}
		
		public function getReferer() : void {
			var href : String;
			try {
				href = ExternalInterface.call.apply( null, RefererJSCode );
			} catch( e : Error ) {
				href = "";
			}
			_jsable = href != "";
			_referer = new URL( href );
		}
		
		public function getFlashVars( swf : DisplayObjectContainer ) : void {
			if( swf )
				readParam( swf.loaderInfo.parameters );
		}
		
		public function readParam( param : Object, reset : Boolean = false ) : void {
			if( param != null ) {
				if( reset ) {
					_flashvars = {};
				}
				for( var i : String in param ) {
					_flashvars[ i.toLowerCase()] = param[ i ];
				}
			}
		}
	
	}
}
