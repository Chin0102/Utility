package cn.chinuy.utils {
	import flash.net.SharedObject;
	
	/**
	 * @author Chin
	 */
	public class SharedObjectUtil {
		public static function setData( dataName : String, data : *, nameSpace : String, localPath : String = "/" ) : void {
			try {
				var so : SharedObject = SharedObject.getLocal( nameSpace, localPath );
				so.data[ dataName ] = data;
				so.flush();
			} catch( e : Error ) {
			}
		}
		
		public static function getData( dataName : String, nameSpace : String, localPath : String = "/" ) : * {
			try {
				var so : SharedObject = SharedObject.getLocal( nameSpace, localPath );
				return so.data[ dataName ];
			} catch( e : Error ) {
				return null;
			}
		}
	}
}
