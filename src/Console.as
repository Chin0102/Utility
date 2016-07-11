package {
	import flash.external.ExternalInterface;
	import flash.utils.getTimer;
	
	public class Console {
		
		//日志
		public static function log( ... msg ) : void {
			jsconsole( "log", msg );
		}
		
		//信息
		public static function info( ... msg ) : void {
			jsconsole( "info", msg );
		}
		
		//警告
		public static function warn( ... msg ) : void {
			jsconsole( "warn", msg );
		}
		
		//错误
		public static function error( ... msg ) : void {
			jsconsole( "error", msg );
		}
		
		public static function jsconsole( type : String, msg : Array ) : void {
			if( ExternalInterface.available ) {
				try {
					ExternalInterface.call.apply( null, [ "console." + type, "[" + getTimer() + "]" ].concat( msg ));
				} catch( e : Error ) {
				}
			} else {
				trace.apply( null, [ "[" + getTimer() + "]" ].concat( msg ));
			}
		}
	}
}
