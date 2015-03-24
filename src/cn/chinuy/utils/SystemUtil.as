package cn.chinuy.utils {
	import flash.system.Capabilities;
	import flash.system.System;
	
	/**
	 * @author Chin
	 */
	public class SystemUtil {
		
		public static function get versionNum() : Number {
			var nums : Array = versionArray;
			var bigVer : String = nums.shift();
			var ver : Number = Number( bigVer + "." + nums.join( "" ));
			return ver;
		}
		
		public static function get versionArray() : Array {
			return String( version.split( " " )[ 1 ]).split( "," );
		}
		
		public static function isBelowVersion( marginalVersion : Number ) : Boolean {
			return versionNum < marginalVersion;
		}
		
		public static function get newline() : String {
			var os : String = version.split( " " )[ 0 ];
			switch( os ) {
				case "MAC":
					return "\r";
				case "LINUX":
					return "\n";
				case "WINDOWS":
				default:
					return "\r\n";
			}
		}
		
		public static function get version() : String {
			return Capabilities.version;
		}
		
		public static function get memory() : Number {
			return System.totalMemory;
		}
		
		public static function gc() : void {
			System.gc();
		}
	
	}
}
